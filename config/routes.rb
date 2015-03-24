Rails.application.routes.draw do

  root 'welcome#index'

  resources :users
  resources :orders
  resources :sessions, only: [:new, :create, :destroy]


  match '/orders/get', to: 'orders#get_order', via: 'post', as: :get_order

  
end
