class JobStatus < ActiveRecord::Base
  # has_many :jobs

  def self.be_array
    all.map{ |status| [status.name, status.id]}
  end

  def name
    I18n.t key
  end
end
