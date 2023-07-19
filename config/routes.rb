Rails.application.routes.draw do
  namespace :admin do
    get 'uses/index'
    get 'uses/new'
    get 'uses/create'
    get 'uses/show'
    get 'uses/edit'
    get 'uses/update'
    get 'uses/destroy'
  end
  root "tasks#index"
  
  resources :tasks
  resources :sessions, only: %i[new create destroy]

end
