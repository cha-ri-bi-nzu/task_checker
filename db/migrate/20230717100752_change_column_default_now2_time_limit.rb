class ChangeColumnDefaultNow2TimeLimit < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :time_limit, :timestamp, null:false, default: -> { 'NOW()' }
  end
end
