class UserJob < ActiveRecord::Base
  # Relationship
  belongs_to :user
  belongs_to :job
end
