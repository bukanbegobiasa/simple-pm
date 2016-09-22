class UserJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_job, only: [:show, :edit, :update, :destroy]

  def index
    @user_jobs = UserJob.all
  end

  def show
  end

  def new
    @user_job = UserJob.new
    render layout: false
  end

  def edit
  end

  def create
    @user_job = UserJob.new(user_job_params)

    respond_to do |format|
      if @user_job.save
        format.html { redirect_to :back, notice: t('success.user_job.create') }
        format.json { render :show, status: :created, location: @user_job }
      else
        format.html { redirect_to :back, notice: t('warning.user_job.create') }
        format.json { render json: @user_job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_job.update(user_job_params)
        format.html { redirect_to @user_job, notice: t('success.user_job.update') }
        format.json { render :show, status: :ok, location: @user_job }
      else
        format.html { render :edit }
        format.json { render json: @user_job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_job.destroy
    respond_to do |format|
      format.html { redirect_to user_jobs_url, notice: 'User job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user_job
      @user_job = UserJob.find(params[:id])
    end

    def user_job_params
      params.require(:user_job).permit(:user_id, :job_id)
    end
end
