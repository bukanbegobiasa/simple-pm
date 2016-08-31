class JobsController < ApplicationController
  before_action :authenticate_user!, :authenticate_project!
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @job = Job.new
    @jobs = Job.eager_load(:job_status, :activity).where(project_id: params[:project_id])
  end

  def show
    @job_activity = JobActivity.new
    @task = @job.tasks
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to project_jobs_path, notice: t('jobs.notice.create') }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { redirect_to project_jobs_path, notice: 'unsuc' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: t('jobs.notice.update') }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: t('jobs.notice.destroy') }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.eager_load(:project, :activity).find(params[:id])
    end

    def job_params
      params.require(:job).permit(:project_id, :title, :description, :start_at, :finish_at, :milestone, :rate, :job_status_id, :active)
    end
end
