class ProductsController < ApplicationController

  def index
    @providers = Provider.all
    @products = Product.order(:name)
    @all_products = @products
    @brands = Brand.all
    @search = Search.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def fetch_products
    providers = Array(params[:provider])
    brands = Array(params[:brands])
    query = params[:query]
    if query.present?
      @records = Product.search_products(query)
    else
      # @records = Product.joins(:provider).where(providers: { name: provider }).where(brand: brand)
      @records = Product.search_products(providers.join(" ") + brands.join(" "))
    end
  end

end
