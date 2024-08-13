class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  before_save :downcase_email_and_username

  private

  def downcase_email_and_username
    self.email = email.downcase
    self.username = username.downcase
  end
  has_secure_password
  has_many :results
  has_many :created_quizzes, class_name: 'Quiz', foreign_key: 'creator_id'
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  attr_accessor :password_confirmation
end
