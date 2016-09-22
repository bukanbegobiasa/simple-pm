class JobActivity < ActiveRecord::Base
  before_save :replace_newlines

  belongs_to :job
  belongs_to :user, foreign_key: :created_by,  class_name: 'User'

  # Validations
  validates :name, presence: true
  validates :job_id, presence: true, numericality: true
  validates :created_by, presence: true, numericality: true

  # Delegates
  delegate :username, :id, to: :user, prefix: true

  scope :active, ->{
    where(active: true)
  }

  def own_activity?(user_id)
    self.created_by == user_id
  end

  def replace_newlines
    self.name.gsub!(/\r\n/, "<br />")
  end
end
