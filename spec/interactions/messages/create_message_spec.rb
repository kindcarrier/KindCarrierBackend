require 'rails_helper'
RSpec.describe CreateMessage do
  let(:user) { create(:user) }
  let(:text) { 'test_text' }
  let(:command) { described_class.run(text: text, deal_id: deal_id, user: user) }
  let(:deal_id) { deal.id }

  describe 'Errors' do
    let(:deal) { create(:deal, negotiation_ids: [999, 777]) }

    it 'return error not belongs to user' do
      expect(command.errors[:deal_id]).to include(I18n.t('active_interaction.errors.messages')[:not_belongs])
    end
  end

  describe 'Execute' do
    let(:negotiation) { create(:negotiation) }
    let(:user_negotiation) { create(:negotiation, user_id: user.id) }
    let(:deal) { create(:deal, negotiation_ids: [negotiation.id, user_negotiation.id]) }

    it 'create message' do
      expect { command }.to change(Message, :count).from(0).to(1)
      expect(Message.first).to have_attributes(text: text, user_id: user.id, deal_id: deal.id)
    end
  end
end
