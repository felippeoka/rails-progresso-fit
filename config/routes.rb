Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resource :profiles, only: %i[show]
  resources :weights, only: %i[new create]
end
