class User < ApplicationRecord
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  before_validation {email.downcase!}
  has_secure_password
  validates :password, length: {minimum: 6}
end
