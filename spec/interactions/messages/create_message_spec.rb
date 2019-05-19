require 'rails_helper'
RSpec.describe CreateMessage do
  let(:user) { create(:user) }
  let(:text) { 'test_text' }
  let(:command) do
    described_class.run(text: text, negotiation_id: negotiation_id, user: user)
  end

  describe 'Errors' do
    let(:negotiation_id) { create(:negotiation).id }

    it 'return error not belongs to user' do
      expect(command.errors[:negotiation_id]).to include(I18n.t('active_interaction.errors.messages')[:not_belongs])
    end
  end

  describe 'Execute' do
    let(:negotiation_id) { create(:negotiation, owner_id: user.id).id }

    it 'create message' do
      expect { command }.to change(Message, :count).from(0).to(1)
      expect(Message.first).to have_attributes(text: text, user_id: user.id, negotiation_id: negotiation_id)
    end
  end
end
