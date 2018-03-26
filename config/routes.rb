Rails.application.routes.draw do
  root             to: 'toppages#index'
  get 'search',    to: 'toppages#search'
  get 'signup',    to: 'users#new'
  get 'login',     to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users,  only: [:index, :show, :create, :edit, :update] do
      member do
      get :followings
      get :followers
    end
  end
  resources :tweets, only: [:create, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :messages, only: [:show, :create, :destroy]
end
