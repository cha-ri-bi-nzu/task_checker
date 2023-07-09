class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :create_new_sort, -> {order(created_at: :desc)}
  scope :time_limit_sort, -> {order(time_limit: :asc)}
end
