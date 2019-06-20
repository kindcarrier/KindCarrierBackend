require 'rails_helper'

RSpec.describe ConfirmNegotiation do
  let(:accepter) { create(:user) }
  let(:owner) { create(:user) }
  let(:negotiation) { create(:negotiation, owner_id: owner.id, status: status) }
  let(:status) { :opened }
  let(:command) { described_class.run(negotiation: negotiation, user: accepter) }

  describe 'Validations' do
    it 'is valid' do
      expect(command).to be_valid
    end

    context 'owner id and accepter id are the same' do
      let(:accepter) { owner }

      it 'returns error' do
        expect(command.errors.full_messages).to include('User is owner of negotiation already')
      end
    end

    context 'negotiation is confirmed already' do
      let(:status) { :confirmed }

      it 'returns error' do
        expect(command.errors.full_messages).to include('Negotiation with status \'opened\' could be confirmed only')
      end
    end
  end

  it 'change negotiation status' do
    expect(command.result).to have_attributes(id: negotiation.id, status: 'confirmed')
  end
end
