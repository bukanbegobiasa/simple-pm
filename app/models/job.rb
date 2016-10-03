class Job < ActiveRecord::Base
  before_save :ensure_job_status_has_value, only: :create
  after_initialize :ensure_job_is_active

  before_save :replace_newlines

  # Relationship
  belongs_to :project
  belongs_to :status, class_name: 'JobStatus', foreign_key: 'job_status_id'

  has_many :activity, class_name: 'JobActivity'
  has_many :tasks

  has_many :user_jobs
  has_many :user, through: :user_jobs

  # Validations
  validates :project, presence: true

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :start_at, :finish_at, presence: true
  validate :finish_must_be_end

  validates :milestone, presence: true, on: :update
  validates :rate, presence: true, on: :update
  validates :job_status_id, presence: true, on: :update
  validates :active, presence: true, on: :update

  # Delegates
  delegate :name, to: :project, prefix: true, allow_nil: true

  # Scopes
  scope :active, ->{
    where(active: true)
  }

  scope :search_jobs, ->(project){
    where("project_id = ? AND title LIKE ?", project[:project_id], "%#{ project[:title] }%")
  }

  def activities
    self.activity.active
  end

  def is_have_a_user user
    self.user_jobs.find_by(user_id: user).present?
  end

  def assign_user user
    if is_have_a_user user
      return true
    elsif self.user_jobs.count > 3
      return false
    elsif self.project.is_quality_assurance? user
      return true
    elsif self.project.is_management? user
      return true
    else
      return UserJob.create({
        user_id: user,
        job_id: self.id
      })
    end
  end

  def update_status status
    if status == 2
      rate = 30
    elsif status == 3
      rate = 70
    elsif status == 4
      rate = 80
    elsif status == 5
      rate = 90
    elsif status == 6
      rate = 60
    else
      rate = 100
    end

    self.update_columns(job_status_id: status, rate: rate)
  end


  private

  def finish_must_be_end
    if finish_at.present? and start_at.present?
      errors.add(:finish_at, "Must be at least 1 month far from start date") if finish_at - start_at < 10000
    end
  end

  def ensure_job_status_has_value
    self.job_status_id = 1 || job_status_id
  end

  def ensure_job_is_active
    self.active = true
  end

  def replace_newlines
    self.description.gsub!(/\r\n/, "<br />")
  end

end
