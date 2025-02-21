Rails.application.routes.draw do
  root "home#index"

  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  delete "signin", to: "sessions#destroy"

  resources :articles do
    resources :comments, only: [ :create, :destroy ]
  end

  resources :categories

  get "signup", to: "users#new", as: :new_user
  resources :users, except: [ :new ]
  get "/users/confirm/:token", to: "users#confirm", as: :confirm_user

  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker

  match "*unmatched",
    to: "application#not_found",
    via: :all,
    constraints: lambda { |req|!req.path.starts_with?("/rails/") }
end
