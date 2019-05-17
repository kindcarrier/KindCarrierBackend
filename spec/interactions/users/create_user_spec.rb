require 'rails_helper'

RSpec.describe CreateUser do
  let(:first_name) { 'John' }
  let(:last_name) { 'Brown' }
  let(:email) { 'john@brown.com' }
  let(:user_params) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end
  let(:command) do
    described_class.run!(user_params.merge(password: '123456'))
  end

  it 'create user with params' do
    expect { command }.to change(User, :count).from(0).to(1)
    expect(User.first).to have_attributes(user_params)
  end
end
