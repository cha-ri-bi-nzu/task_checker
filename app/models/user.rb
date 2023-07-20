class User < ApplicationRecord
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank

  has_secure_password
  validates :password, length: { minimum: 6 }
end
