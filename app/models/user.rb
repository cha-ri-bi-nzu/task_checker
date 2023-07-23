class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  before_validation {email.downcase!}
  has_secure_password
  validates :password, length: {minimum: 6}

  enum admin: {管理者: true, 一般: false}

  # before_update UpdateAdminAtCallback.new
end
