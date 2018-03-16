Rails.application.routes.draw do
  root             to: 'toppages#index'
  get 'signup',    to: 'users#new'
  get 'login',     to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users,  only: [:show, :create, :edit, :update]
  resources :tweets, only: [:create, :edit, :update, :destroy]
end
