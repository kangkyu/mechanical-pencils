Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :items, only: [:index, :show, :new, :create] do
    collection do
      get 'collection'
    end
    member do
      post 'own'
      post 'unown'
    end
    resources :ownerships
  end
  resources :item_groups, only: [:index, :show]

  namespace :admin do
    resources :items, only: [:edit, :update, :destroy]
    resources :item_groups, only: [:new, :create, :edit, :update, :destroy]
  end

  root "landing#index"

  resource :session
  resources :users, only: [:show] do
    member do
      get 'share'
      post 'share_post'
    end
  end

  get "/threads/oauth/callback", to: "users#threads_auth"
end
