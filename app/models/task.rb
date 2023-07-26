class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :create_new_sort, -> {order(created_at: :desc)}
  scope :time_limit_sort, -> {reorder(time_limit: :desc)}
  scope :name_select, -> (name){where("name LIKE ?", "%#{name}%")}
  scope :status_select, -> (status){where(status: status)} # {where(status: params[:status])}
  scope :high_priority_sort, -> {reorder(priority: :asc)}
  
  enum status: {未着手: 0, 着手中: 1, 完了: 2}
  enum priority: {高: 0, 中: 1, 低: 2}

  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labeling_labels, through: :labelings, surce: :label
end
