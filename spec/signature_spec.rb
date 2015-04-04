require 'spec_helper'
require 'cider_ci/open_session/signature'

describe CiderCi::OpenSession::Signature do
  describe 'create' do
    it "dosen't raise" do
      expect do
        CiderCi::OpenSession::Signature.create 'secret', 'message'
      end.not_to raise_error
    end
  end

  describe 'create and validate! cycle' do
    it 'with valid signature passes' do
      signature = CiderCi::OpenSession::Signature.create 'secret', 'message'
      expect do
        CiderCi::OpenSession::Signature.validate! signature, 'secret', 'message'
      end.not_to raise_error
    end

    it 'with different messages raises' do
      signature = CiderCi::OpenSession::Signature.create 'secret', 'messageS'
      expect do
        CiderCi::OpenSession::Signature.validate! signature, 'secret', 'message'
      end.to raise_error CiderCi::OpenSession::Signature::ValidationError
    end

    it 'with different secrets raises' do
      signature = CiderCi::OpenSession::Signature.create 'secretX', 'message'
      expect do
        CiderCi::OpenSession::Signature.validate! signature, 'secret', 'message'
      end.to raise_error CiderCi::OpenSession::Signature::ValidationError
    end

    it 'raises with modified signature' do
      signature = CiderCi::OpenSession::Signature.create('secretX', 'message') \
                  .gsub('9', '0')
      expect do
        CiderCi::OpenSession::Signature.validate! signature, 'secret', 'message'
      end.to raise_error CiderCi::OpenSession::Signature::ValidationError
    end
  end

  describe 'fixed secrete, message and signature' do
    let :signature do
      '0caf649feee4953d87bf903ac1176c45e028df16'
    end
    it 'is valid' do
      expect(
        CiderCi::OpenSession::Signature.valid? signature, 'secret', 'message'
      ).to be true
    end
  end
end
