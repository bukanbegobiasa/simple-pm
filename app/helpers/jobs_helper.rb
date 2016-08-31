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
end
