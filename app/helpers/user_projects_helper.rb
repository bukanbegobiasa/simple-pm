module UserProjectsHelper
  def generate_new_user
    if @project.is_management?current_user.id
      texting = "<a href='#expand' class='g-user_project__button_new' onclick='toogle_new_user_project(); return false;'>" + t('expand') + "</a>"
    else
      texting = ""
    end

    raw texting
  end
end
