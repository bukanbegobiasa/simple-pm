class UserProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_project, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  def index
    @user_projects = UserProject.eager_load(:user, :project, :role).where(project_id: params[:project_id])
    @user_project = UserProject.new
    @roles = Role.javascript_json
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @user_project = UserProject.new(user_project_params)

    respond_to do |format|
      if @user_project.save
        format.html { redirect_to project_user_projects_path, notice: 'success'}
        format.json { render :show, status: :created, location: @user_project }
      else
        format.html { redirect_to project_user_projects_path, notice: 'Unsuccess'}
        format.json { render json: @user_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_project.update(user_project_params)
        format.html { redirect_to @user_project, notice: 'User project was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_project }
      else
        format.html { render :edit }
        format.json { render json: @user_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_project.destroy
    respond_to do |format|
      format.html { redirect_to user_projects_url, notice: 'User project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user_project
      @user_project = UserProject.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def user_project_params
      params.require(:user_project).permit(:user_id, :project_id, :role_id)
    end
end
