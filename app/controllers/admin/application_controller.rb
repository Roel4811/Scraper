class Admin::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  prepend_view_path Rails.root.join("app/frontend")
  layout 'admin'

  def home
  end
end