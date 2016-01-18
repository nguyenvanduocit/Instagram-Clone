Rails.application.routes.draw do

  resources :roles
  resources :hashtags
  resources :comments
  resources :posts
  root 'common_pages#home'

  get 'about' => 'common_pages#about'
  get 'help' => 'common_pages#help'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :relationships,       only: [:create, :destroy]
  resources :post,          only: [:create, :destroy]
end
