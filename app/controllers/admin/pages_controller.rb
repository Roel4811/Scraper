class Admin::PagesController < Admin::ApplicationController
  before_action :authenticate!

  def home
  end

  def database
    @products = Product.all
  end

  private

  # redirect user to /login if he hadn't picked a username yet
  def authenticate!
    redirect_to admin_login_path unless session[:username]
  end
end
