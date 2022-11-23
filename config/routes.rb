Rails.application.routes.draw do
  devise_for :users

  resources :users do
    get "/full_profile", to: "profiles#full_profile"
    patch "/full_profile", to: "profiles#full_profile_edit"
  end

  root to: "pages#home"

  resource :profiles, only: %i[show]
  resources :weights, only: %i[new create show destroy]
end
