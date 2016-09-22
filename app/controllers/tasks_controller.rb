class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, :set_job
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
    render layout: false
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.json { render :show, status: :created, location: @task }
        format.html { redirect_to project_job_path(@project, @job), notice: t('success.task.create') }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.html { redirect_to project_job_path(@project, @job), notice: t('warning.task.create') }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_job_path(@project, @task.job), notice: t('success.task.update') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.update_columns(status: false)
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: t('success.task.delete') }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_job
      @job = Job.find(params[:job_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:job_id, :name, :description, :status, :created_by)
    end
end
