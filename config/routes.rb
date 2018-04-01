Rails.application.routes.draw do
  root to: "pages#home"

  namespace :admin do
    root to: "pages#home"

    get  "/login", to: "auth#new"
    post "/login", to: "auth#create"

    get '/scraper-input', to: "application#scraper_input"
    get '/database', to: "pages#database"
    post '/create-products', to: "products#create_products"
  end
end
