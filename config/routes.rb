Board::Application.routes.draw do
  resources :comments

  resources :courses do
      resources :topics
  end

  resources :users, :sessions

  get '/signin' => "sessions#new", :as => :signin
  get '/signout' => "sessions#destroy", :as => :signout

  get '/course/:course_id/topics/:topic_id/reply' => "topics#reply", :as => :reply_course_topic
  post '/course/:course_id/topics/:topic_id/reply' => "topics#save_comment", :as => :reply_course_topic
  get '/course/:course_id/topics/:topic_id/add_vote' => "topics#add_vote", :as => :add_vote_course_topic_comment
  get '/course/:course_id/topics/:topic_id/subtract_vote' => "topics#subtract_vote", :as => :subtract_vote_course_topic_comment

  root :to => "courses#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
