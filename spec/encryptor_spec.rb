require 'cider_ci/open_session/encryptor'

describe CiderCi::OpenSession::Encryptor do
  describe 'call encrypt' do
    it 'does not raise an error ' do
      CiderCi::OpenSession::Encryptor.encrypt('secret', x: 42)
    end
  end

  def rand_message_object
    { 'a' => rand(10).times.map { rand(100) },
      'b' => rand(2).zero?,
      'rand-string' => rand(100).times.map do
        (' '.ord + (rand '~'.ord - ' '.ord)).chr
      end.join,
      'f' => rand,
      'i' => rand(100) }
  end

  describe 'back-compat by decrypting a fixed message'  do
    it 'returns something equal the encrypted object' do
      expect(CiderCi::OpenSession::Encryptor.decrypt(
               'secret', 'wHGrlC7kOvd0T90uNlEc_A~jfUriLEgN7mhM3eLQJ6WsA'))
        .to be == { 'x' => 42 }
    end
  end

  describe 'encrypt and decrypt cycle' do
    it 'returns an equivalent of the original message' do
      100.times do
        rmo = rand_message_object
        expect(CiderCi::OpenSession::Encryptor.decrypt(
                 'secret', CiderCi::OpenSession::Encryptor.encrypt(
                             'secret', rmo))).to be == rmo
      end
    end
  end
end
