class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :create_new_sort, -> {order(created_at: :desc)}
  scope :time_limit_sort, -> {order(time_limit: :asc)}
  scope :name_select, -> (name){where("name LIKE ?", "%#{name}%")}
  scope :status_select, -> (status){where(status: status)} # {where(status: params[:status])}
  scope :priority_select, -> (priority){where(priority: priority)}

  enum status: {未着手: 0, 着手中: 1, 完了: 2}
  enum priority: {高: 0, 中: 1, 低: 2}
end
