require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { 'Some unique email' }
  let(:password) { 'Some password' }
  let(:first_name) { 'Some first name' }
  let(:last_name) { 'Some last name' }
  let!(:user) do
    build(:user, email: email, password: password,
                 first_name: first_name, last_name: last_name)
  end

  shared_examples 'invalid' do
    it 'is invalid' do
      expect(user).to be_invalid
    end
  end

  shared_examples 'valid' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  describe 'validations' do
    context 'no email' do
      let(:email) { nil }

      it_behaves_like 'invalid'
    end

    context 'non-unique email' do
      let!(:old_user) do
        create(:user, email: 'some@old.email',
                      password: password, first_name: first_name, last_name: last_name)
      end
      let(:email) { 'some@old.email' }

      it_behaves_like 'invalid'
    end

    context 'no first name' do
      let(:first_name) { nil }

      it_behaves_like 'invalid'
    end

    context 'no last name' do
      let(:last_name) { nil }

      it_behaves_like 'invalid'
    end

    context 'valid parameters' do
      it_behaves_like 'valid'
    end
  end

  describe 'authentication' do
    let(:authenticate_result) { described_class.authenticate!(email, auth_password) }
    let(:auth_password) { password }

    it 'raises exception if no user' do
      expect { authenticate_result }.to raise_error Exceptions::UnauthorizedError
    end

    context 'created user' do
      let!(:created_user) { user.save! }

      it 'returns user' do
        expect(authenticate_result).to eq(user)
      end

      context 'wrong password' do
        let(:auth_password) { 'ama_wrong' }

        it 'raises exception' do
          expect { authenticate_result }.to raise_error Exceptions::UnauthorizedError
        end
      end
    end
  end
end
