CopilotV0::Application.routes.draw do
  resources :travels do
      resources :stages do
        collection { post :sort }
       end
  end

   resources :januaries do
    collection { post :import }
  end

  resources :climates do
    collection { post :import }
  end

  root "climates#index"

  get "landing/landing3"
  get "landing/landing4"


  devise_for :users, controllers: { registrations: 'registrations'}
  get "home/index"
  get "home/profile"
  get "home/help"
  get "home/landing2"
  get "home/contact"
  get "home/about"
  get "landing/landing"
  get "landing/landing2"
  get "maps/index"
  get "travels/index"
  resources :prospects

  # resources :maps

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # root 'landing#landing1'

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
