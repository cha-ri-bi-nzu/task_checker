class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :create_new_sort, -> {order(created_at: :desc)}
  scope :time_limit_sort, -> {order(time_limit: :asc)}
  scope :name_select, -> (name){where("name LIKE ?", "%#{name}%")}
  scope :status_select, -> (status){where(status: status)} # {where(status: params[:status])}

  enum status: {未着手: 0, 着手中: 1, 完了: 2}
end
