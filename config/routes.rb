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
  # get '*path' => redirect( '/404.html' )


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
