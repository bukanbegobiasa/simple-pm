class JobActivitiesController < ApplicationController
  before_action :authenticate_user!, :authenticate_project!
  before_action :set_job
  before_action :set_activity, only: [:edit, :update, :destroy]

  def index
    @job_activities = JobActivity.all
  end

  def show
    @job_activities = @job.activities
  end

  def new
    @job_activity = JobActivity.new
  end

  def edit
  end

  def create
    @job_activity = JobActivity.new(job_activity_params)

    respond_to do |format|
      if @job_activity.save
        format.html { redirect_to :back, notice: t('success.job_activity.create') }
      else
        format.html { redirect_to :back, warning: t('warning.job_activity.create') }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_activity.update(job_activity_params)
        format.html { redirect_to project_job_path(@project, @job), notice: t('success.job_activity.update') }
        format.json { render :show, status: :ok, location: @job_activity }
      else
        format.html { render :edit, warning: t('warning.job_activity.update') }
        format.json { render json: @job_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_activity.update_columns(active: false)
    respond_to do |format|
      format.html { redirect_to project_job_path(@project, @job), notice: t('success.job_activity.delete') }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.eager_load(:project, :activity).find(params[:job_id])
    end

    def set_activity
      @job_activity = JobActivity.find(params[:id])
    end

    def job_activity_params
      params.require(:job_activity).permit(:job_id, :name, :created_by)
    end
end
