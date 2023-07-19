Rails.application.routes.draw do
  root "tasks#index"
  
  resources :tasks
  resources :sessions, only: %i[new create destroy]

end
