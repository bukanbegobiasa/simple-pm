module TasksHelper
  def task_status(status)
    rendered = t('task.not_active')
    rendered = t('task.active') if status
    rendered
  end

  def generate_task_action task
    if @project.is_management? current_user.id
      texting = link_to t('edit'), edit_project_job_task_path(@project,@job, task),
                  onclick: "open_modal(this); return false;", id: "edit_task",
                  style: "margin-right: 12px;",
                  data: { url: edit_project_job_task_url(@project, @job, @task)}
    else
      texting = ""
    end

    texting
  end

  def task_status_info task
    text = t('process')
    text = t('finish') if task.status

    text
  end

  def task_status_action task
    if (@project.is_management? current_user.id or @job.owned current_user.id) and not task.status
      text = link_to t('finish'), project_job_task_finish_path(@project, @job, task), class: 'g-project__edit__button', style: 'margin-top: 4px;'
    end
  end

  def generate_task_status_style task
    now = Date.today
    end_date = task.finish_at.to_date
    result = (end_date - now).to_i

    if result <= 2
      text = '#CE1010'
    elsif result <= 6
      text = '#E5A329'
    elsif result <= 10
      text = '#D5D81E'
    else
      text = '#49AD35'
    end

    if task.status
      text = '#287BEF'
    end

    return text
  end
end
