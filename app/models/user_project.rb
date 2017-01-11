class UserProject < ActiveRecord::Base
  # Relationship
  belongs_to :user
  belongs_to :role
  belongs_to :project

  # Validates
  validates :project, :role, :user_id, presence: true

  # Delegations
  delegate :name, to: :role, prefix: true

  # Pagination
  paginates_per 10

  def self.create_new resources
    user_project = self.eager_load(:user, :role, :project).new({
      user_id: resources[:user_id],
      project_id: resources[:project_id],
      role_id: 1
    })

    user_project.save
  end

  def owner
    self.find_by(role_id: 1).user
  end

  def self.auth?(user, role)
    return self.find_by(user_id: user, role_id: role).present?
  end

  def define_role id
    self.where(project_id: id).first.role.name
  end
end
