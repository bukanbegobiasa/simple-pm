class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def authenticate_user!
  #   redirect_to new_user_session_path unless current_user.present?
  # end

  def authenticate_project!
    @project = Project.find(params[:project_id]) if Project.authenticate!(params[:project_id])
  end

  def is_belongs_to_project?
    redirect_to root_url, alert: t('warning.project.not_authenticate') unless @project.is_user_belongs_to_project(current_user.id)
  end
end
