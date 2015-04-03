require 'cider_ci/open_session/encryptor'

describe CiderCi::OpenSession::Encryptor do
  describe 'call encrypt' do
    it 'does not raise an error ' do
      CiderCi::OpenSession::Encryptor.encrypt('secret', x: 42)
    end
  end

  let :encrypted_object do
    'wHGrlC7kOvd0T90uNlEc_A~jfUriLEgN7mhM3eLQJ6WsA'
  end

  let :message_object do
    { 'x' => 42 }
  end

  describe 'back-compat by decrypting a fixed message'  do
    it 'returns something equal the encrypted object' do
      expect(CiderCi::OpenSession::Encryptor.decrypt(
               'secret', encrypted_object)).to be == message_object
    end
  end

  describe 'encrypt and decrypt cycle' do
    it 'returns an equivalent of the original message' do
      expect(CiderCi::OpenSession::Encryptor.decrypt(
               'secret', CiderCi::OpenSession::Encryptor.encrypt(
                           'secret', message_object))).to be == message_object
    end
  end
end
