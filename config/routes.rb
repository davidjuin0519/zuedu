Rails.application.routes.draw do
  
  devise_for :members, controllers: { sessions: 'sessions', omniauth_callbacks: 'members/omniauth_callbacks' }
  
  devise_for :users, controllers: { sessions: 'sessions' }

  resources :carts, only: %i[index]
  resources :products, only: %i[show index]
  resources :line_items, only: %i[index create update destroy]
  resources :orders, only: %i[index new show create]

  get 'members/get_member' => 'members#get_member'

  namespace :allpay do
    get 'form/:order_id', action: :form, as: :form
    post :callback
  end

  namespace :dashboard do
    resources :products, :product_details, :carts, :members, :discounts
    resources :line_items do
      post 'download_csv', on: :collection
    end
    resources :orders do
      post 'remind', on: :collection
    end
  end

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
