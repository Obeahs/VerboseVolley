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
  resources :carts
  resources :categories

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  root 'pages#home'
end
