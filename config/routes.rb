Rails.application.routes.draw do
  get 'uses/index'
  get 'uses/new'
  get 'uses/create'
  get 'uses/show'
  get 'uses/edit'
  get 'uses/update'
  get 'uses/destroy'
  root "tasks#index"

  resources :tasks
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit update destroy]
  namespace :admin do
    resources :users
  end
end
