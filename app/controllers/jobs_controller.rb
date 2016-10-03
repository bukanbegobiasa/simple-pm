class JobsController < ApplicationController
  before_action :authenticate_user!, :authenticate_project!
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @job = Job.new
    @jobs = Job.eager_load(:activity).where(project_id: params[:project_id])
  end

  def show
    @task = Task.new
    @tasks = @job.tasks
    @user_job = UserJob.new
    @job_activity = JobActivity.new
    @job_activities = @job.activities
    @list_users = @project.participants
  end

  def new
    @job = Job.new
  end

  def search
    @job = Job.new
    @jobs = Job.eager_load(:activity).search_jobs(job_params)
    render 'index'
  end

  def edit
    render layout: false
  end

  def status
    @job = Job.eager_load(:project, :activity).find(params[:job_id])
    @status = JobStatus.be_array
    render layout: false
  end

  def milestone
    @job = Job.eager_load(:project, :activity).find(params[:job_id])
    render layout: false
  end

  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to project_jobs_path(@project), notice: t('success.job.create') }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { redirect_to project_jobs_path(@project), notice: t('warning.job.create') }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update_columns(job_params)
        format.html { redirect_to project_job_path(@project,@job) , notice: t('success.job.update') }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, warning: t('warning.job.update') }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    status = { "start"=>2, "finish"=>3, "deliver"=>4, "accept"=>7, "restart"=>2, "reject"=>2 }
    @job = Job.find(params[:job_id])
    respond_to do |format|
      if @job.assign_user current_user.id
          if @job.update_status(status[params['commit']])
          format.html { redirect_to project_job_path(@project,@job) , notice: t('success.job.update') }
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit, warning: t('warning.job.update') }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @job.update_columns(active: false)

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: t('success.job.destroy') }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.eager_load(:project, :activity).find(params[:id])
    end

    def job_params
      params.require(:job).permit(:project_id, :title, :description, :start_at, :finish_at, :milestone, :rate, :status, :active)
    end
end
