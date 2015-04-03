require 'base64'

module CiderCi
  module OpenSession
    module Encoder
      extend self
      def encode(msg)
        ::Base64.urlsafe_encode64 msg
      end

      def decode(msg)
        ::Base64.urlsafe_decode64 msg
      end
    end
  end
end
