class PagesController < ApplicationController
  def home
    @providers = Provider.all
    @products = Product.all
    @brands = @products.distinct.pluck(:brand).select(&:present?)
  end

  def search_products
    @provider = params[:provider]
    @brand = params[:brand]
    binding.pry
  end
end
