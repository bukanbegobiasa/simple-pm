class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :project,    index: true,  foreign_key: true
      t.string :title,          null: false,  default: ""
      t.text :description,      null: false,  default: ""
      t.datetime :start_at,     null: false
      t.datetime :finish_at,    null: false
      t.integer :milestone,     null: false,  default: 0
      t.integer :rate,          null: false,  default: 0
      t.belongs_to :job_status, index: true,  foreign_key: true
      t.boolean :active,        null: false,  default: true

      t.timestamps null: false
    end
  end
end
