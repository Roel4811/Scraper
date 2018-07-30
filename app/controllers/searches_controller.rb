class SearchesController < ApplicationController
  def create
    @search = Search.create!(search_params)

    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
    @records = @search.products
  end

  private

  def search_params
    params.require(:search).permit(:keywords, :min_price, :max_price, brands: [], providers: [])
  end
end
