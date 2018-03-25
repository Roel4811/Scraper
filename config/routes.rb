Rails.application.routes.draw do
  root to: "pages#home"

  namespace :admin do
    root to: "pages#home"
  end
end
