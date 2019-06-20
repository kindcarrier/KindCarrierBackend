require 'rails_helper'

RSpec.describe Negotiation, type: :model do
  let(:owner) { create(:user) }
  let(:accepter) { create(:user) }
  let!(:negotiation) do
    build(:negotiation, owner_id: owner, accepter_id: accepter.id)
  end

  shared_examples 'invalid' do
    it 'is invalid' do
      expect(negotiation).to be_invalid
    end
  end

  shared_examples 'valid' do
    it 'is valid' do
      expect(negotiation).to be_valid
    end
  end

  describe 'validations' do
    context 'valid parameters' do
      it_behaves_like 'valid'
    end
  end
end
