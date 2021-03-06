Rails.application.routes.draw do

  #devise_for :users 
  devise_for :users, controllers: {sessions: "sessions", :registrations => "registrations"}

  get 'users/panel'
  get 'users/user_info'
  get 'users/del'

  get 'profiles/edit'
  patch 'profiles/update'

  get 'services/index'
  get 'services/show'
  get 'services/new'
  get 'services/create'
  get 'services/destroy'
  get 'services/edit'
  get 'services/contact_us'
  post 'services/send_email'
  post 'services/update'

  get 'orders/prueba'
  get 'orders/index'
  get 'orders/show'
  get 'orders/show_pagadas'
  get 'orders/new'
  get 'orders/create'
  get 'orders/destroy'
  get 'orders/edit'
  get 'orders/ver_detalles'
  get 'orders/eliminar_orden'

  post 'orders/envio'

  post 'orders/create'
  post 'orders/procesar_order'
  post 'orders/procesar_transferencia'
  post 'orders/transferencia_pagada'

  get 'folders/index'
  get 'folders/show'
  get 'folders/new'
  get 'folders/create'
  get 'folders/destroy'
  get 'folders/edit'

  get 'payments/procesar_transferencia'
  get 'payments/ver_detalles'
  get 'payments/orden_finalizada'
  get 'payments/count_new_orders'

  resources :services
  resources :folders
  resources :orders
  resources :admins
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

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
