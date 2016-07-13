class Task < ActiveRecord::Base
  belongs_to :job

  Validation
  validates :job, absence: true
  validates :name, presence: true
  validates :created_by, numericality: true, presence: true
end
