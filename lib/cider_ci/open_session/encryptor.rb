require 'cider_ci/open_session/encoder'
require 'cider_ci/open_session/signature'
require 'openssl'
require 'json'

module CiderCi
  module OpenSession
    module Encryptor
      include CiderCi::OpenSession::Encoder
      extend self

      def decrypt(secret, encrypted_message)
        iv, encrypted_data, sig = encrypted_message.split('~').map { |m| decode(m) }
        CiderCi::OpenSession::Signature.validate! sig, secret, encrypted_data
        cipher = create_cipher :decrypt, secret
        cipher.iv = iv
        decrypted_data = cipher.update(encrypted_data)
        decrypted_data << cipher.final
        JSON.parse(decrypted_data)
      end

      def encrypt(secret, message_object)
        cipher = create_cipher :encrypt, secret
        iv = cipher.random_iv
        encrypted_data = cipher.update(message_object.to_json)
        encrypted_data << cipher.final
        sig = CiderCi::OpenSession::Signature.create secret, encrypted_data
        "#{encode iv}~#{encode encrypted_data}~#{encode sig}"
      end

      private

      def create_cipher(mode, secret)
        OpenSSL::Cipher::Cipher.new('aes-256-cbc').tap do |c|
          c.send mode
          c.key = Digest::SHA256.digest(secret)
        end
      end
    end
  end
end
