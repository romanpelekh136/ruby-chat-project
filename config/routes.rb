Rails.application.routes.draw do
  devise_for :users

  resources :rooms, only: [ :index, :show, :create, :destroy, :update, :edit ] do
    resources :messages, only: [ :create ]
  end

  root "rooms#index"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    post "register", to: "registration#create"
    post "login", to: "sessions#create"

    resources :rooms, only: [ :index, :show, :destroy, :create ]
  end
end
