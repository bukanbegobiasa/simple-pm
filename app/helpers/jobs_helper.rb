module JobsHelper
  def job_title (title)
    t('job.title') + ' : ' + title
  end

  def user_assignment job
    texting = t('job.unassigned')

    if job.user.present?
      texting = raw("<ul>")

      job.user.each do |user|
        texting += raw("<li>" + user.username + "</li>")
      end

      texting += raw("</ul>")
    end

    texting
  end

  def assigned job
    if (job.user.blank? or job.user.count <= 3) and @project.is_management? current_user.id
      texting = raw("<a class='g-job__button__edit__assignment' href='#expand' onclick=toogle_user_job(); return false;>" + t('user_job.add') + "</a>")
    else
      texting = ''
    end

    texting
  end

  def generate_milestone job
    if job.is_have_a_user current_user.id and job.job_status_id != 7
      texting = link_to t('job.add_milestone'), project_job_milestone_path(@project, job),
                  onclick: "open_modal(this); return false", id: "new_milestone",
                  data: { url: project_job_milestone_url(@project, job) }
    else
      # texting = link_to t('job.edit_milestone'), project_job_milestone_path(@project, job),
      #             onclick: "open_modal(this); return false", id: "new_milestone",
      #             data: { url: project_job_milestone_url(@project, job) }
      texting = ""
    end
    texting
  end

  def is_created job
    return ((job.user.blank? or job.user.count <= 3) and @project.is_management? current_user.id)
  end

  def can_edit job
    if @project.is_management?(current_user.id) and job.job_status_id != 7
      texting = link_to t('job.edit'), edit_project_job_path(@project, job),
                  onclick: "open_modal(this); return false", id: "edit_job",
                  class: "g-project__edit__button", data: { url: edit_project_job_url(@project, job) }
    end

    texting
  end

  def new_task_link user
    return link_to t('expand'), root_url, class: "g-task__flag-new__action__button", onclick: "toogle_new_task(); return false;" if @project.is_management? user.id
  end
end
