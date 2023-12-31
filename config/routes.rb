Rails.application.routes.draw do
  # Add a route for checking the user's authentication status
  devise_scope :user do
    get '/auth_check', to: 'users/sessions#auth_check'
    # post '/login', to: 'users/sessions#login'
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :users do
    collection do
      post 'refresh_token'
    end
  end

  # Public route for Farmer dashboard
  get 'farmer/dashboard' # Uncomment if needed

  # Authenticated user root route
  authenticated :user do
    root 'sessions#after_sign_in_path_for'
  end

  # Admin dashboard route
  get 'admin/dashboard', to: 'admin#dashboard', as: :admin_dashboard

  # Authenticated Buyer dashboard route (generated by Devise)
  authenticated :user do
    get 'buyer/dashboard', to: 'buyer#dashboard', as: :buyer_dashboard
  end

  resources :products do
    get 'search', on: :collection
  end

  resources :farmers, only: [:show] do
    get 'reviews', on: :member
  end

  
  # Resourceful routes for various entities
  resources :orders
  resources :products
  resources :categories
  resources :users
end