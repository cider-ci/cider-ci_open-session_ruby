require 'spec_helper'
require 'cider_ci/open_session/encryptor'

describe CiderCi::OpenSession::Encryptor do
  describe 'call encrypt' do
    it 'does not raise an error ' do
      CiderCi::OpenSession::Encryptor.encrypt('secret', x: 42)
    end
  end

  def rand_string
    rand(100).times.map do
      (' '.ord + (rand '~'.ord - ' '.ord)).chr
    end.join
  end

  def rand_message_object
    { 'a' => rand(10).times.map { rand(100) },
      'b' => rand(2).zero?,
      'rand-string' => rand_string,
      'f' => rand,
      'i' => rand(100) }
  end

  let :fixed_object do
    { 'a' => [81, 46, 60, 44, 6, 54],
      'b' => false,
      'rand-string' => 'S?OsOT<h(7&$$@R<Saa;',
      'f' => 0.27856255867921376,
      'i' => 29 }
  end

  let :encrypt_of_fixed_object do
    '__uAbdDGfcBYLcx-xZGbGw~Br17ojhdaJKfBVr76WeXADdWtDrXRFmdiu91e98YSz84X1ma' \
    '-41QUcGiYk7IEGwELFXdWN4VY_f9rcuuMBd7-zviX65eaX2MKs9fwk2CcRI8z9p4twqDV44' \
    'YIFvi5A7F4olio5DczkxTqacg6jgLEQ'
  end

  describe 'back-compat by decrypting a fixed message'  do
    it 'returns something equal the encrypted object' do
      expect(CiderCi::OpenSession::Encryptor.decrypt(
               'secret', encrypt_of_fixed_object))
        .to be == fixed_object
    end
  end

  describe 'encrypt and decrypt cycle' do
    it 'returns an equivalent of the original message' do
      100.times do
        original_message_object = rand_message_object
        encrypted = CiderCi::OpenSession::Encryptor.encrypt(
          'secret', original_message_object)
        decrypted = CiderCi::OpenSession::Encryptor.decrypt('secret', encrypted)
        expect(decrypted).to be == original_message_object
      end
    end
  end
end
