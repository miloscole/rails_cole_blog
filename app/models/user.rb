class User < ApplicationRecord
  include ArticlesPaginatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: 3..25
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save { self.email = email.downcase }

  generates_token_for :email_confirmation, expires_in: 2.days do
    email
  end

  def confirm!
    update!(confirmed_at: Time.current)
  end

  def confirmed?
    confirmed_at.present?
  end
end
