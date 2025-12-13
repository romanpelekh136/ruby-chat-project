Rails.application.routes.draw do
  devise_for :users

  resources :rooms, only: [ :index, :show, :create ]

  root "rooms#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
