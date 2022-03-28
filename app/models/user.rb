class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 25 }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {maximum: 105},
            format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  attr_accessor :password_confirmation

  validate :password_matches_password_confirmation

  def password_matches_password_confirmation
    errors.add :password_confirmation, 'must match your password' if :password.eql? :password_confirmation
  end
end