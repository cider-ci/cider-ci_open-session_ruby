require "cider_ci/open_session/encryptor" 


describe CiderCi::OpenSession::Encryptor do 

  describe "call encrypt" do

    it "does not raise an error " do
      CiderCi::OpenSession::Encryptor.encrypt("secret",{x: 42})
    end

  end

  describe "encrypt and decrypt cycle" do

    let :message_object do
      {"x" => 42}
    end

    it "returns an equivalent of the original message" do
      expect( 
             CiderCi::OpenSession::Encryptor.decrypt(
               "secret", CiderCi::OpenSession::Encryptor.encrypt("secret",message_object))
            ).to be== message_object
    end


  end
end

