Rails.application.routes.draw do

  root 'welcome#index'

  resources :users
  resources :orders
  resources :sessions, only: [:new, :create, :destroy]

  
end
