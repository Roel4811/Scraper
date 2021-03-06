Rails.application.routes.draw do
  root to: "products#index"
  get "/over", to: "application#about", as: "about"
  get "/contact", to: "application#contact"
  get "/search-products", to: "products#fetch_products", as: "fetch_products"
  get "/zoeken", to: "products#index"

  resources :products, only: [:index, :show]
  post "/contact_submission", to: "application#create_contact_submission"

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
