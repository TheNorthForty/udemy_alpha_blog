Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  # restrict resource creation to show
  resources :articles #, only: [:show, :index, :new, :create, :edit, :update, :destroy] 
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
