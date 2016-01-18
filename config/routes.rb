Rails.application.routes.draw do

  root 'common_pages#home'

  get 'about' => 'common_pages#about'
  get 'help' => 'common_pages#help'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy'

  resources :users
end
