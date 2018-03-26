Rails.application.routes.draw do
  root to: "pages#home"

  namespace :admin do
    root to: "pages#home"
    post "application#scraper_input"
  end
end
