class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labeling_tasks, through: :labelings, surce: :task
end
