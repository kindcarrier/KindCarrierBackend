require 'rails_helper'

RSpec.describe Negotiation, type: :model do
  let(:owner) { create(:user) }
  let(:accepter) { create(:user) }
  let!(:negotiation) do
    build(:negotiation,
      owner_id: owner.id, accepter_id: accepter.id,
      name: name, description: description, service_cost: service_cost,
      status: status)
  end
  let(:name) { 'Chezh beer' }
  let(:description) { 'That\'s good' }
  let(:service_cost) { 24.5 }
  let(:status) { :opened }

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

    context 'no name' do
      let(:name) { nil }

      it_behaves_like 'invalid'
    end

    context 'no description' do
      let(:description) { nil }

      it_behaves_like 'invalid'
    end

    context 'no service cost' do
      let(:service_cost) { nil }

      it_behaves_like 'invalid'
    end

    context 'negative service cost' do
      let(:service_cost) { -2.0 }

      it_behaves_like 'invalid'
    end

    context 'no status' do
      let(:status) { nil }

      it_behaves_like 'invalid'
    end
  end
end
