class JobActivitiesController < ApplicationController
  before_action :authenticate_user!, :authenticate_project!
  before_action :set_job

  def index
    @job_activities = JobActivity.all
  end

  def show
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
        format.html { redirect_to @job_activity, notice: t('job_activities.notice.save') }
        format.json { render :show, status: :created, location: @job_activity }
      else
        format.html { render :new }
        format.json { render json: @job_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_activity.update(job_activity_params)
        format.html { redirect_to @job_activity, notice: t('job_activities.notice.update') }
        format.json { render :show, status: :ok, location: @job_activity }
      else
        format.html { render :edit }
        format.json { render json: @job_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_activity.destroy
    respond_to do |format|
      format.html { redirect_to job_activities_url, notice: t('job_activities.notice.delete') }
      format.json { head :no_content }
    end
  end

  private
    def set_job
      @job = Job.eager_load(:project, :activity).find(params[:job_id])
    end

    def job_activity_params
      params.require(:job_activity).permit(:job_id, :name, :active)
    end
end
