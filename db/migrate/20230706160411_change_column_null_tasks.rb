class ChangeColumnNullTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :content, :text, null: false
  end
end
