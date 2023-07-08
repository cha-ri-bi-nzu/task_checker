class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  # scope :create_new_sort, -> {order(created_at: :asc)}
end
