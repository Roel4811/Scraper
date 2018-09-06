class SearchesController < ApplicationController

  def index
    redirect_to root_path
  end

  def create
    @search = Search.create!(search_params)

    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
    @records = @search.products
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

  def search_params
    params.require(:search).permit(:keywords, :min_price, :max_price, brands: [], providers: [])
  end
end
