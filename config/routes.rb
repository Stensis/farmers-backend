Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'

      devise_for :farmers, controllers: {
        registrations: 'api/v1/farmers/registrations'
      }

      devise_for :buyers, controllers: {
        registrations: 'api/v1/buyers/registrations'
      }

      devise_scope :buyer do
        post '/buyers/signup', to: 'buyers/registrations#create'
      end

      devise_scope :farmer do
        post '/farmers/signup', to: 'farmers/registrations#create'
      end
    end
  end

  resources :orders
  resources :products
  resources :categories
  resources :buyers
  resources :farmers
end
