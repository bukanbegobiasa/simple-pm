class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name,         null: false
      t.string :price,        null: true
      t.datetime :start_at,   null: false
      t.datetime :finish_at,  null: false
      t.datetime :real_finish_at,  null: true
      t.boolean :active,      null: false,    default: true

      t.timestamps null: false
    end
  end
end
