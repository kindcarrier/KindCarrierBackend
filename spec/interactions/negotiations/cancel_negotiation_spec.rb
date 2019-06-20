require 'rails_helper'

RSpec.describe CancelNegotiation do
  let(:accepter) { create(:user) }
  let(:owner) { create(:user) }
  let(:negotiation) do
    create(:negotiation, accepter_id: accepter.id, owner_id: owner.id, status: status)
  end
  let(:command) { described_class.run(negotiation: negotiation, user: canceler) }
  let(:canceler) { accepter }
  let(:status) { :confirmed }

  describe 'Validations' do
    it 'is valid' do
      expect(command).to be_valid
    end

    context 'user does not belong to negotiation' do
      let(:canceler) { create(:user) }

      it 'returns error' do
        expect(command.errors[:negotiation]).to include(I18n.t('active_interaction.errors.messages')[:not_belongs])
      end
    end

    context 'negotiation is opened' do
      let(:status) { :opened }

      it 'returns error' do
        expect(command.errors[:negotiation]).to include(I18n.t('active_interaction.errors.messages')[:not_confirmed])
      end
    end
  end

  it 'change negotiation status' do
    expect(command.result.status).to eq('canceled')
  end
end
