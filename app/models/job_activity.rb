class JobActivity < ActiveRecord::Base
  belongs_to :job

  # Validations
  validates :name, presence: true
  validates :job, absence: true, numericality: true
  validates :created_by, presence: true, numericality: true
end
