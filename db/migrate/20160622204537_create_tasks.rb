class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :job,        index: true, foreign_key: true
      t.string :name,           null: false, default: ''
      t.boolean :status,        null: false
      t.boolean :active,        null: false, default: true
      t.string :description,    null: false, default: ''
      t.integer :process
      t.datetime :start_at,     null: false
      t.datetime :finish_at,    null: false
      t.integer :created_by,    null: false

      t.timestamps null: false
    end
  end
end
