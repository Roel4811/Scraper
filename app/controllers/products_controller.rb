class ProductsController < ApplicationController
  def index
    @providers = Provider.all
    @products = Product.search_products("*")
    @brands = Product.distinct.pluck(:brand).select(&:present?)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search_products
    provider = params[:provider]
    brand = params[:brand]
    query = params[:query]
    if query.present?
      @records = Product.search_products(query)
    else
      # @records = Product.joins(:provider).where(providers: { name: provider }).where(brand: brand)
      @records = Product.search_products("#{provider} #{brand}")
    end
  end

end
