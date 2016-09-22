class Task < ActiveRecord::Base
  before_save :replace_newlines
  belongs_to :job

  # Validation
  validates :job_id, presence: true
  validates :name, presence: true
  validates :created_by, presence: true

  def replace_newlines
    self.description.gsub!(/\r\n/, "<br /> ")
  end

end
