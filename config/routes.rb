Rails.application.routes.draw do
  resources :comments do
    collection do
      get :all_comments
    end
  end
  resources :goals
  resources :users do
    member do
      get :user_activity
    end
    collection do
      post :follow_unfollow
    end
  end
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  post 'authenticate_by_access_token', to: 'authentication#authenticate_by_access_token'
  get 'goals_notifications', to: 'goals#goals_notifications'
end
