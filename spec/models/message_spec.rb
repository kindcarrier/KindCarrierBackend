require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:text) { 'Hi there! Wanna some German beer?' }
  let(:user) { create(:user) }
  let(:negotiation_accepter) { create(:user) }
  let(:negotiation) do
    create(:negotiation, owner: user,
                         accepter: negotiation_accepter, status: :confirmed)
  end
  let!(:message) do
    build(:message, text: text, user: user, negotiation: negotiation)
  end

  shared_examples 'invalid' do
    it 'is invalid' do
      expect(message).to be_invalid
    end
  end

  shared_examples 'valid' do
    it 'is valid' do
      expect(message).to be_valid
    end
  end

  describe 'validations' do
    context 'no user' do
      let(:user) { nil }

      it_behaves_like 'invalid'
    end

    context 'no text' do
      let(:text) { nil }

      it_behaves_like 'invalid'
    end

    context 'no negotiation' do
      let(:negotiation) { nil }

      it_behaves_like 'invalid'
    end

    context 'valid parameters' do
      it_behaves_like 'valid'
    end
  end
end
