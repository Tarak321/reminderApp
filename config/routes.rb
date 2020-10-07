Rails.application.routes.draw do
  resources :medical_histories
    
  get "medical_histories/:user_id/users_with_deps", to: "medical_histories#get_self_and_dependents"
  get "medical_histories/:user_id/users", to: "medical_histories#get_for_self"
  get "medical_histories/:user_id/deps", to: "medical_histories#get_for_dependents"
  get "dependents/:user_id/deps", to: "dependents#get_dependents_of_user"


  post "sessions/changepass", to: "sessions#changepass"

  resources :dependents
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # root 'users#new'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root 'home#index'
 
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new',  as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  delete 'logout', to: 'sessions#destroy', as: 'logout_delete'
  put 'dependents/updep/updep',to: "dependents#updep"
  get 'home/index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
