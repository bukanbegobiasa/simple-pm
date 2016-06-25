require 'test_helper'

class UserJobsControllerTest < ActionController::TestCase
  setup do
    @user_job = user_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_job" do
    assert_difference('UserJob.count') do
      post :create, user_job: { job_id: @user_job.job_id, user_id: @user_job.user_id }
    end

    assert_redirected_to user_job_path(assigns(:user_job))
  end

  test "should show user_job" do
    get :show, id: @user_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_job
    assert_response :success
  end

  test "should update user_job" do
    patch :update, id: @user_job, user_job: { job_id: @user_job.job_id, user_id: @user_job.user_id }
    assert_redirected_to user_job_path(assigns(:user_job))
  end

  test "should destroy user_job" do
    assert_difference('UserJob.count', -1) do
      delete :destroy, id: @user_job
    end

    assert_redirected_to user_jobs_path
  end
end
