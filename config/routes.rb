GarrioServer::Application.routes.draw do
  
  root 'pages#home'
  
  get  'auth/google_oauth2/callback', to: 'sessions#callback'
  post 'auth/google_oauth2/callback', to: 'sessions#callback'
  get  'auth/failure',            to: 'sessions#ofailure' # was to: redirect('/'),
  
  # post 'google', to: 'sessions#google'
  match 'auth/google_oauth2', to: 'sessions#options', via: [:options]
  
  resources :languages
  resources :users
  resources :ranks
  resources :sessions, only: [:new, :create, :destroy]
  
  get 'home', controller: 'pages', action: 'home'
  get 'login', controller: 'sessions', action: 'create'
  get 'logout', controller: 'sessions', action: 'destroy'
  
  scope :format => true, :constraints => { :format => 'json' } do
    namespace :api do
      namespace :v1 do
        get "check" => "sessions#check"
        get "login" => "sessions#create"
        get "logout" => "sessions#destroy"
        # get "google" => "sessions#google"
        # get "callback" => "sessions#callback"
       
        match 'check', to: 'sessions#options', via: [:options]
        match 'login', to: 'sessions#options', via: [:options]
        match 'logout', to: 'sessions#options', via: [:options]
        # match 'google', to: 'sessions#options', via: [:options]
        # match 'callback', to: 'sessions#options', via: [:options]
        
        # match 'auth/failure', to: 'sessions#options', via: [:options]
        # match 'auth/google_oauth2', to: 'sessions#options', via: [:options]
        # match 'auth/google_oauth2/callback', to: 'sessions#options', via: [:options]
      end
    end
  end
    
end