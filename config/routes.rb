Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :customers
  resources :orders
  resources :products
  resources :products_carts
  resource :cart, only: [:show] do
    post 'add/:id', to: 'carts#add', as: 'add_to'
    delete 'remove/:id', to: 'carts#remove', as: 'remove_from'
    patch 'update/:id', to: 'carts#update', as: 'update'
  end
  
  resources :categories

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  root 'pages#home'
end
