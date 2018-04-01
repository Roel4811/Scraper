class Admin::AuthController < Admin::ApplicationController
  before_action :only_for_anonymous # check if we know the user

  def new; end

  # Get username from params, save to session and redirect to admin_root
  def create
    session[:username] = params[:username]
    redirect_to admin_root_path
  end

  private

  # If a user has been here before — send them straight to admin_root
  def only_for_anonymous
    redirect_to admin_root_path if session[:username]
  end
end
