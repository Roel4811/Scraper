class Admin::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  prepend_view_path Rails.root.join("app/frontend")
  layout 'admin'

  def home
  end

  def scraper_input
    url = params[:url]
    service = params[:service]

    if service == 'Bol'
      @records = BolScraperService.new(url).call
    elsif service == 'Coolblue'
      @records = CbScraperService.new(url).call
    end
  end

  private

  def scraper_input_params

  end
end
