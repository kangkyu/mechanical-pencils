Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      resource :session, only: [:create, :destroy]
      resource :registration, only: [:create]
      resources :items, only: [:index, :show] do
        member do
          post :own
          delete :unown
        end
      end
      resources :ownerships, only: [:update]
      resource :collection, only: [:show]
      resources :makers, only: [:index]
      resources :item_groups, only: [:index, :show]
      resources :users, only: [:show]
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
  resources :items, only: %i[index show new create] do
    collection do
      get "collection"
    end
    member do
      post "own"
      post "unown"
    end
    resources :ownerships
  end
  resources :item_groups, only: %i[index show]

  namespace :admin do
    resources :items, only: %i[edit update destroy]
    resources :item_groups, only: %i[new create edit update destroy]
  end

  root "landing#index"

  resource :session
  resources :users, only: [:show] do
    member do
      get "share"
      post "share_post"
    end
  end

  get "/threads/oauth/callback", to: "users#threads_auth"
end
