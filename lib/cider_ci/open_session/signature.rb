module CiderCi
  module OpenSession
    module Signature
      extend self

      def create(secret, message)
        OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new('sha1'),
          secret, message)
      end

      def valid?(signature, secret, message)
        signature == create(secret, message)
      end

      def validate!(signature, secret, message)
        unless valid?(signature, secret, message)
          fail 'Signature validation failed!'
        end
      end
    end
  end
end
