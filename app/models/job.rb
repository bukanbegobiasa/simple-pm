class Job < ActiveRecord::Base
  after_initialize  :ensure_job_status_has_value,
                    :ensure_job_is_active
  # Relationship
  belongs_to :project
  belongs_to :job_status

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
  validates :job_status, presence: true, on: :update
  validates :active, presence: true, on: :update

  # Delegates
  delegate :name, to: :project, prefix: true, allow_nil: true

  # Scopes
  scope :active, ->{
    where(active: true)
  }


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

end
