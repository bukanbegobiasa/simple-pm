class User < ActiveRecord::Base
  before_create :assign_initial_value

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationship
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :user_jobs
  has_many :jobs, through: :user_jobs

  # Validations
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, presence: true, length: { in: 8..50 }
  validates :username, presence: true, length: { minimum: 5 }
  validates :fullname, presence: true, length: { minimum: 5 }
  validates :gender, presence: true, inclusion: { in: [true, false] }

  scope :search_user, ->(term){
    where('email LIKE ? OR username LIKE ?', "%#{ term }%", "%#{ term }%")
  }

  def all_jobs project
    if project.is_management? self.id
      project.jobs
    else
      self.jobs.where("project_id = ?", project.id)
    end
  end

  def define_role id
    self.user_projects.where(project_id: id).first.role.name
  end

  private
  def assign_initial_value
    self.initial = username[0..2].upcase
  end
end
