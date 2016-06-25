class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :key
      t.integer :level

      t.timestamps null: false
    end
  end
end
