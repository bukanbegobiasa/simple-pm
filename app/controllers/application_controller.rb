class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    current_user.present?
  end

  def authenticate_project!
    Project.authenticate!(params[:project_id])
  end
end
