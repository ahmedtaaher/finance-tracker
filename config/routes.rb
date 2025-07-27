Rails.application.routes.draw do
  resources :user_stocks, only: [ :create, :destroy ]
  devise_for :users
  root "welcome#index"
  get "my_portfolio", to: "users#my_portfolio"
  get "search_stock", to: "stocks#search"
  get "my_friends", to: "users#my_friends"
  get "search_friend", to: "users#search"
  resources :friendships, only: [ :create, :destroy ]
  resources :users, only: [ :show ]
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
