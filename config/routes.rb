Rails.application.routes.draw do

  root 'pages#home'
  get '/about' => 'pages#about'

  # Login page
  get '/login' => 'sessions#new', :as => 'login'

  # Sign Up
  post '/login' => 'sessions#create'

  # Logout
  delete '/logout' => 'sessions#destroy'

  get '/posts' => 'posts#show_all', :as => 'posts'


  post '/users/:user_id/posts/:post_id/comments/magictouch' => 'comments#create_magic_touch', :as => 'magic_touch'
  post '/users/:user_id/posts/:post_id/comments/mainstream' => 'comments#create_mainstream', :as => 'mainstream'
  post '/users/:user_id/posts/random' => 'posts#create_random_post', :as => 'random_post'
  # User routes
  resources :users do
    member do
      get :following, :followers
    end
    # Post routes
    resources :posts do
      # Comment routes
      resources :comments do
      end
    end
  end

  resources :relationships, :only => [ :create, :destroy ]

  end
