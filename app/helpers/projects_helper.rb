module ProjectsHelper
  def rupiah number
    number_to_currency(number, unit: 'Rp. ', separator: ',', delimiter: '.')
  end

  def indonesian_time time
    time.strftime('%d-%m-%Y')
  end

  def generate_edit_project project
    texting = link_to t("project.edit"), edit_project_path(project),
                id: 'edit_project', onclick: "open_modal(this);return false",
                class: 'g-project__edit__button', data: { url: edit_project_url(project)}
    return texting if project.is_management? current_user
  end
end
