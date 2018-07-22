Rails.application.routes.draw do

  root 'welcome#index'

  resources :stations, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :users, only: [:new, :create]

  resources :conditions

  get '/dashboard', to: 'dashboard#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
