class StyleguidesController < ApplicationController
  before_action :check_environment

  def index
    render layout: false
  end

  private
  def check_environment
    redirect_to root_url unless Rails.env.development?
  end
end
