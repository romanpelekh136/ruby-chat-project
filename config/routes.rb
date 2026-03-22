Rails.application.routes.draw do
  get "messages/create"
  devise_for :users

  resources :rooms, only: [ :index, :show, :create, :destroy ] do
    resources :messages, only: [ :create ]
  end

  root "rooms#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
