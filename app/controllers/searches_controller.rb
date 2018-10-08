class SearchesController < ApplicationController
  before_action :find_search, only: [:show, :update]

  def index
    redirect_to root_path
  end

  def create
    if @search = Search.create!(search_params)
      redirect_to @search
    else
      render 'search_went_wrong'
    end
  end

  def show
    @all_products = Product.where(id: @search.products.map(&:id))
    @products = @all_products.order(:name).page(params[:page]).per(9)
    @providers = Provider.all
    @brands = Brand.all
  end

  def update
    if @search.update!(search_params)
      redirect_to @search
    else
      render 'search_went_wrong'
    end
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
    params.require(:search).permit(:keywords, :min_price, :max_price, brand_ids: [], provider_ids: [])
  end
end
