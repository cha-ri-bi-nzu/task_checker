Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit update destroy]
  namespace :admin do
    resources :users, only: %i[index new create edit update destroy]
  end
end
