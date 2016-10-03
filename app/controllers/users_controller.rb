class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def search
    term = params[:search][:term]
    result = User.search_user term
    render json: result
  end

  def show
    @user = User.find(params[:user_id])
    @projects = @user.projects
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:user_id, :username, :initial, :fullname)
  end
end
