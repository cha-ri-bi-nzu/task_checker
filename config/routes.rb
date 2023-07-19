Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/new'
    get 'users/create'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
  end
  root "tasks#index"

  resources :tasks
  resources :sessions, only: %i[new create destroy]

end
