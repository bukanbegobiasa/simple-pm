class Task < ActiveRecord::Base
  before_save :replace_newlines
  before_save :check_percentage
  belongs_to :job

  # Validation
  validates :job_id, presence: true
  validates :name, presence: true
  validates :created_by, presence: true

  private

  def replace_newlines
    self.description.gsub!(/\r\n/, "<br /> ")
  end

  def check_percentage
    percent = self.process
    self.job.tasks.each do |task|
      percent += task.process
    end

    return percent <= 100
  end

end
