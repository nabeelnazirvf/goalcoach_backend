Rails.application.routes.draw do
  resources :goals
  resources :users
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  post 'authenticate_by_access_token', to: 'authentication#authenticate_by_access_token'
end
