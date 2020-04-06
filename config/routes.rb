Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get :following, :followers, :likes
    end
  end

  resources :posts do
    member do
      get :likes
    end
  end

  resources :posts, :relationships, :likes, :blocks
  root 'pages#index'

  get 'home' => 'pages#home'
  get 'search/' => 'pages#search'
  get 'search/:search' => 'pages#search'
  get 'user/:id' => 'pages#profile'
  get 'post/:id' => 'pages#post'
  get 'explore' => 'pages#explore'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
