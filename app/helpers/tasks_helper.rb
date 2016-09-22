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
end
