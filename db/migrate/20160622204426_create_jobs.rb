class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :finish_at
      t.integer :milestone
      t.integer :rate
      t.belongs_to :job_status, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
