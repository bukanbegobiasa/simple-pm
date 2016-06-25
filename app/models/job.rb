class Job < ActiveRecord::Base
  # Relationship
  belongs_to :project
  belongs_to :job_status

  has_many :activity, class_name: 'JobActivity'
  has_many :tasks
end
