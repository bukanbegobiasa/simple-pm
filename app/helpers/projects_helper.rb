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

  def generate_result(job)
    "resullt"
  end

  def generate_summary_status(task)
    text = if task.status then t('finish') else t('process') end
  end

  def generate_summary_result(task)
    text = if task.status then '100 %' else '0 %' end
  end

  def calculate_result(task)
    text = if task.status then 1 else 0 end
    number = task.process * text
    number
  end

  def calculate_final(number, job)
    final = (number * job.percent)/100
    final
  end

  def generate_project_status_style project
    now = Date.today
    end_date = project.finish_at.to_date
    result = (end_date - now).to_i

    if result <= 30
      text = '#CE1010'
    elsif result <= 60
      text = '#E5A329'
    elsif result <= 90
      text = '#D5D81E'
    else
      text = '#49AD35'
    end

    return text
  end

end

