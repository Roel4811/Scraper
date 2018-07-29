class SearchesController < ApplicationController
  def create
    binding.pry
    @search = Search.create!(params[:search])
    @records = @search.products
  end

  def show
    @search = Search.find(params[:id])
  end
end
