class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  prepend_view_path Rails.root.join("app/frontend")

  def about
    @providers = Provider.all
    @products = Product.order(:name)
    @brands = Product.present_brands
    @search = Search.new

    respond_to do |format|
      format.html
      format.js {
        render 'about'
      }
    end
  end

  def contact
    @providers = Provider.all
    @products = Product.order(:name)
    @brands = Product.present_brands
    @search = Search.new

    respond_to do |format|
      format.html
      format.js {
        render 'contact'
      }
    end
  end
end
