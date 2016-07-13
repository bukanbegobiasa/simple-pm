module ApplicationHelper
  def title name
    default = 'Dee Management System'
    return name + ' | ' + default if name.present?
    default
  end
end
