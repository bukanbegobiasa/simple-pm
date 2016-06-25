class CreateJobActivities < ActiveRecord::Migration
  def change
    create_table :job_activities do |t|
      t.belongs_to :job, index: true, foreign_key: true
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
