class ProductsController < ApplicationController
  def index
    @providers = Provider.all
    @products = Product.all
    @brands = @products.distinct.pluck(:brand).select(&:present?)
  end

  def show
  end

  def search_products
    provider = params[:provider]
    brand = params[:brand]

    @records = Product.joins(:provider).where(providers: { name: provider }).where(brand: brand)
  end
end
