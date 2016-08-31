class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    current_user.present?
  end

  def authenticate_project!
    @project = Project.find(params[:project_id]) if Project.authenticate!(params[:project_id])
  end
end
