Rails.application.routes.draw do
  get 'users/index'
  get 'users/new'
  get 'users/create'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  root "tasks#index"

  resources :tasks
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit update destroy]
  namespace :admin do
    resources :users
  end
end
