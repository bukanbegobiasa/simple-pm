module JobActivitiesHelper
  def generate_activity_actions activity, user_id
    if activity.own_activity?(user_id)
      rendered = raw("<div class='g-activity__actions'><div class='g-activity__actions__edit'>")
      rendered += link_to t("job.edit"), edit_project_job_job_activity_path(@project, @job, activity)
      rendered += raw("</div><div class='g-activity__actions__delete'>")
      rendered += link_to t("job.delete"),
        project_job_job_activity_path(@project, @job, activity),
        method: :delete, data: { confirm: 'Are you sure?' }
      rendered += raw("</div></div>")
      rendered
    end
  end
end
