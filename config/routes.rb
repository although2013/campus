Rails.application.routes.draw do

  root 'welcome#index'

  resources :users, param: :name
  resources :orders
  resources :sessions, only: [:new, :create, :destroy]


  match '/orders/get', to: 'orders#get_order', via: 'post', as: :get_order
  match '/orders/cancel', to: 'orders#cancel_order', via: 'post', as: :cancel_order
  match '/orders/pending', to: 'orders#pending_order', via: 'post', as: :pending_order
  match '/orders/star', to: 'orders#do_star', via: 'post', as: :do_star
  match '/orders/wrong/:id', to: 'orders#wrong_order', via: 'get', as: :wrong_order
  match '/orders/finished', to: 'orders#finished_order', via: 'post', as: :finished_order
  match '/search', to: 'orders#search', via: 'get', as: :search
end
