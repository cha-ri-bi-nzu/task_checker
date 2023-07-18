class ChangeColumnDefaultNowTimeLimit < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :time_limit, :timestamp, null:false, default: DateTime.now
  end
end
