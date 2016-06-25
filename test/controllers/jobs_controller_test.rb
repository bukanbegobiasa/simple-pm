require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post :create, job: { active: @job.active, description: @job.description, finish_at: @job.finish_at, job_status_id: @job.job_status_id, milestone: @job.milestone, project_id: @job.project_id, rate: @job.rate, start_at: @job.start_at, title: @job.title }
    end

    assert_redirected_to job_path(assigns(:job))
  end

  test "should show job" do
    get :show, id: @job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job
    assert_response :success
  end

  test "should update job" do
    patch :update, id: @job, job: { active: @job.active, description: @job.description, finish_at: @job.finish_at, job_status_id: @job.job_status_id, milestone: @job.milestone, project_id: @job.project_id, rate: @job.rate, start_at: @job.start_at, title: @job.title }
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete :destroy, id: @job
    end

    assert_redirected_to jobs_path
  end
end
