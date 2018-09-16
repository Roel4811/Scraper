class SearchesController < ApplicationController
  before_action :find_search, only: [:show, :update]

  def index
    redirect_to root_path
  end

  def create
    @search = Search.create!(search_params)

    redirect_to @search
  end

  def show
    @products = Product.where(id: @search.products.map(&:id))
    @providers = Provider.all
    @brands = Product.present_brands
  end

  def update
    @search.update(search_params)

    redirect_to @search
  end

  def autocomplete
    render json: Product.search(params[:query], {
        fields: ["name"],
        match: :word_middle,
        limit: 10,
        load: false,
        misspellings: {below:5}
      }).map(&:name)
  end

  private

  def find_search
    @search = Search.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:keywords, :min_price, :max_price, brands: [], providers: [])
  end
end
