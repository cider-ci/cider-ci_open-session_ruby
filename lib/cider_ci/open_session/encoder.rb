require 'base64'

module CiderCi
  module OpenSession
    module Encoder
      extend self
      def encode(msg)
        ::Base64.urlsafe_encode64(msg).gsub(/[=]+$/, '')
      end

      def decode(msg)
        ::Base64.urlsafe_decode64(
          case msg.length % 4
          when 2
            msg + '=='
          when 3
            msg + '='
          else
            msg
          end)
      end
    end
  end
end
