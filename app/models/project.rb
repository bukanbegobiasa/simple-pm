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

  def self.authenticate!(project_id)
    return self.where(id: project_id).present?
  end

  def self.create_new(params, user)
    params[:price].remove!('.').remove(',')
    self.create!(params)
  end

  def include_users
    user = self.user_projects.where("role_id != ?", 1).map{|u| u.user_id }
    self.users.where(id: user)
  end

  def is_management?(user)
    roles = Role.management
    return self.user_projects.where(role_id: roles, user_id: user).present?
  end

  def is_quality_assurance?(user)
    roles = Role.quality_assurance
    return self.user_projects.where(role_id: roles, user_id: user).present?
  end

  def save_all(user)
    self.save and UserProject.create_new({project_id: self.id, user_id: user.id })
  end

  def owner
    self.user_projects.find_by(role_id: 1).user.fullname
  end

  def owner?(user)
    return self.user_projects.auth?(user.id, 1)
  end

  def manager?(user)
    return self.user_projects.auth?(user.id, 2)
  end

  def role(user)
    self.user_projects.find_by(user_id: user).role_name
  end

  def is_user_belongs_to_project user
    self.user_projects.where(user_id: user).present?
  end

  def job_participants(job)
    roles = Role.not_management
    project_partisipants = self.user_projects.where(role_id: roles).map{ |user| user.user_id }
    user_ids = project_partisipants - job.user.ids

    if user_ids.blank?
      user = [[ "not_assigned", 0 ]]
    else
      user = User.find(user_ids).map{|user| [user.username, user.id]}
    end

    user
  end

  private

  def finish_must_be_end
    if finish_at.present? and start_at.present?
      errors.add(:finish_at, "Must be at least 1 month far from start date") if finish_at - start_at < 2650000
    end
  end

end
