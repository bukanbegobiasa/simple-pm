class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationship
  has_many :user_projects
  has_many :project, through: :user_projects
  has_many :user_jobs
  has_many :jobs, through: :user_jobs
end
