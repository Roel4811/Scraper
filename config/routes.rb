Rails.application.routes.draw do
  root to: "products#index"
  get "/search-products", to: "products#fetch_products", as: "fetch_products"

  resources :products, only: [:index, :show]
  resources :searches do
    collection do
      get :autocomplete
    end
  end

  namespace :admin do
    root to: "pages#home"

    get  "/login", to: "auth#new"
    post "/login", to: "auth#create"

    get '/scraper-input', to: "application#scraper_input"
    get '/database', to: "pages#database"
    post '/create-products', to: "products#create_products"
  end
end
