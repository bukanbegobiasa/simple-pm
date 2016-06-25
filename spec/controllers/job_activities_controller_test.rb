require 'test_helper'

class JobActivitiesControllerTest < ActionController::TestCase
  setup do
    @job_activity = job_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_activity" do
    assert_difference('JobActivity.count') do
      post :create, job_activity: { active: @job_activity.active, job_id: @job_activity.job_id, name: @job_activity.name }
    end

    assert_redirected_to job_activity_path(assigns(:job_activity))
  end

  test "should show job_activity" do
    get :show, id: @job_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_activity
    assert_response :success
  end

  test "should update job_activity" do
    patch :update, id: @job_activity, job_activity: { active: @job_activity.active, job_id: @job_activity.job_id, name: @job_activity.name }
    assert_redirected_to job_activity_path(assigns(:job_activity))
  end

  test "should destroy job_activity" do
    assert_difference('JobActivity.count', -1) do
      delete :destroy, id: @job_activity
    end

    assert_redirected_to job_activities_path
  end
end
