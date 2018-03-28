Rails.application.routes.draw do
  root to: "pages#home"

  namespace :admin do
    root to: "pages#home"
    get '/scraper-input', to: "application#scraper_input"
  end
end
