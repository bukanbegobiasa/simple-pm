class CreateJobStatuses < ActiveRecord::Migration
  def change
    create_table :job_statuses do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
