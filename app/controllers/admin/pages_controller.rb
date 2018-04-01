class Admin::PagesController < Admin::ApplicationController
  def home
  end

  def database
    @products = Product.all
  end
end
