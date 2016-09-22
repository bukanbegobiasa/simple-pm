module UsersHelper
  def genderize gender
    gender = t('user.male')
    gender = t('user.female') if not gender
    gender
  end

  def generate_link user
    if user.id == current_user.id
      texting = link_to t('user.edit'), edit_user_registration_path,
                    onclick: "open_modal(this); return false;",
                    data: { url: edit_user_registration_url }
    else
      texting = ''
    end

    texting
  end
end
