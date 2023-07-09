class AddTimeLimitToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :time_limit, :timestamp, null:false
  end
end
