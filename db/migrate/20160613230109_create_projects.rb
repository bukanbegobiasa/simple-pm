class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :price
      t.datetime :start_at
      t.datetime :finish_at
      t.boolean :active

      t.timestamps null: false
    end
  end
end
