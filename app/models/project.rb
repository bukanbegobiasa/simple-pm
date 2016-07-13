class Project < ActiveRecord::Base
  has_many :jobs
  has_many :user_projects
  has_many :users, through: :user_projects

  # Validations
  validates :name, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: true
  validates :start_at, :finish_at, presence: true
  validates :active, presence: true, on: :update
  validate :finish_must_be_end


  def save_all(user)
    self.save and UserProject.create_new({project_id: self.id, user_id: user.id })
  end

  def owner?(user)
    return self.user_projects.find_by(user_id: user.id, role_id: 1).present?
  end

  private

  def finish_must_be_end
    if finish_at.present? and start_at.present?
      errors.add(:finish_at, "Must be at least 1 month far from start date") if finish_at - start_at < 2650000
    end
  end

end
