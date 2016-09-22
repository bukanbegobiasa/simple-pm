class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_project, only: [:show, :edit, :update, :destroy, :detail]
  before_action :is_belongs_to_project?, only: [:show]

  def index
    render 'landing/home', layout: false unless current_user
    @projects = current_user.projects if current_user
  end

  def show
  end

  def detail
  end

  def new
    @project = Project.new
    render layout: false
  end

  def edit
    render layout: false
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save_all current_user
        format.html { redirect_to root_path, notice: t('success.project.create') }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, warning: t('warning.project.create')}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_detail_path(@project), notice: t('success.project.update')}
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, warning: t('warning.project.update') }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.update_columns(active: false)
    respond_to do |format|
      format.html { redirect_to projects_url, notice: t('success.project.delete')}
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :price, :start_at, :finish_at, :active)
    end
end
