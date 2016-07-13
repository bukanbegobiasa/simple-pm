class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :job,      index: true, foreign_key: true
      t.string :name,         null: false, default: ''
      t.boolean :status,      null: false, default: 1
      t.integer :created_by,  null: false

      t.timestamps null: false
    end
  end
end
