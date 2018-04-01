Rails.application.routes.draw do
  root to: "pages#home"

  namespace :admin do
    root to: "pages#home"
    get '/scraper-input', to: "application#scraper_input"
    get '/database', to: "pages#database"
    post '/create-products', to: "products#create_products"
  end
end
