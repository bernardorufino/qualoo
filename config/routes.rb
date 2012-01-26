Qualoo::Application.routes.draw do
  # Reedited not to use shallow because if used we have to declare twice,
  # AND one of the declaration brokes, avoiding us to define the search method
  
  CRUD = [:show, :edit, :update, :destroy];
  
  root :to => "pages#welcome";
  
  resources :consumer_salesperson_relationships;  

  resources :tags do
    resources :consumer_salesperson_relationships, except: CRUD;
  end
  
  resources :messages do
    collection do
      get "search";
      get "sent";
      get "received";
    end
  end
  
  match "inbox" => "messages#received", :as => :inbox;
  
  resources :companies do
    get "search", on: :collection;
  end
  
  resources :categories do
    get "search", on: :collection;
  end
  
  resources :users do
    get "search", on: :collection;
  end
  
  resources :salespeople do
    resources :consumers, except: CRUD;
    get "search", on: :collection;
  end
  
  resources :consumers do
    resources :salespeople, except: CRUD;
    get "search", on: :collection;    
  end;
  
  resource :session, :search;
  
  match "login" => "sessions#new", :as => :login;
  match "logout" => "sessions#destroy", :as => :logout;
  match "page/:action", :controller => "pages", :as => :page;
  
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
  # match ':controller(/:action(/:id(.:format)))'
end
