class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_project, except: [:index, :new, :create]
  before_action :is_belongs_to_project?, only: [:show]

  def index
    render 'landing/home', layout: false unless current_user
    @projects = current_user.projects if current_user
  end

  def show
  end

  def detail
  end

  def project_summary
    @jobs = @project.jobs.order("created_at ASC")

    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:      "#{ @project.name.parameterize }_#{ Time.now.strftime('%Y-%m-%d') }",
                layout:   "pdf",
                template: "projects/_project_summary.html.slim"
      end
    end
  end

  def user_summary
    @users = User.all

    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:      "#{ @project.name.parameterize }_users_#{ Time.now.strftime('%Y-%m-%d')}",
                layout:   "pdf",
                template: "projects/_user_summary.html.slim"
      end
    end
  end

  def new
    @project = Project.new
    render layout: false
  end

  def edit
    render layout: false
  end

  def create
    @project = Project.create_new(project_params, current_user)

    respond_to do |format|
      if create_user_project_association(@project, current_user)
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

    def create_user_project_association(project, user)
      UserProject.create!(user_id: user.id, project_id: project.id, role_id: 1)
    end
end
