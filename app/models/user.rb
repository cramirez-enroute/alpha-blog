class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles
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
  validates :password_confirmation, presence: true, length: { minimum: 8, maximum: 25 }

  def password_matches_password_confirmation
    if :password.eql? :password_confirmation
      errors.add :password_confirmation, "must match your password"
    end
  end
end