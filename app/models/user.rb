class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  
  validates :first_name, :last_name, :password, :email,
    :crypted_password, presence: true
  validates :email, uniqueness: true

  before_create :generate_token

  def self.authenticate!(email, password)
    user = authenticate(email, password)

    raise Exceptions::UnauthorizedError, 'Incorrect login or password' unless user

    user
  end

  def authenticate(email, password)
    user = find_by(email: email)

    return if user.blank?

    user.valid_password?(password)
  end

  def generate_token
    self.token ||= SecureRandom.hex
  end
end
