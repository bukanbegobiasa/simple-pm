class CreateJobActivities < ActiveRecord::Migration
  def change
    create_table :job_activities do |t|
      t.belongs_to :job,  index: true, foreign_key: true
      t.string :name,     null: false
      t.boolean :active,  null: false, default: true
      t.integer :created_by, null: false

      t.timestamps null: false
    end
  end
end
