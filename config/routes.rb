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
end
