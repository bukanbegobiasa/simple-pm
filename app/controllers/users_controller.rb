class UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    term = params[:search][:term]
    result = User.where('email LIKE ? OR username LIKE ?', "%#{ term }%", "%#{ term }%")
    render json: result
  end
end
