class AddColumnToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :active, :boolean, default: true
    change_column :tasks, :status, :boolean, default: false
  end
end
