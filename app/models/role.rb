class Role < ActiveRecord::Base
  has_many :user_projects, inverse_of: :role

  def self.javascript_json
    all.map{ |role| {id: role.id, text: I18n.t(role.key)}}.to_json
  end

  def name
    I18n.t key
  end

  def to_json options = {}
    {
      id:   id,
      text: name
    }
  end
end
