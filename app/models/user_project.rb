class UserProject < ActiveRecord::Base
  # Relationship
  belongs_to :user
  belongs_to :role
  belongs_to :project
end
