Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  resources :users, param: :name
  resources :sessions, only: [:new, :create, :destroy]

  resources :orders do
    member do
      match 'get', to: 'orders#get_order', via: 'post', as: :get_order
      match 'cancel', to: 'orders#cancel_order', via: 'post', as: :cancel_order
      match 'pending', to: 'orders#pending_order', via: 'post', as: :pending_order
      match 'star', to: 'orders#do_star', via: 'post', as: :do_star
      match 'wrong', to: 'orders#wrong_order', via: 'get', as: :wrong_order
      match 'finished', to: 'orders#finished_order', via: 'post', as: :finished_order
    end
    collection do
      match '/search', to: 'orders#search', via: 'post', as: :search
    end
  end

end
