IServe::Application.routes.draw do

  get 'management',                 to: 'management_home#index'

  get  'kitchenstaff',              to: 'kitchen_staff_home#index'
  post 'kitchenstaff/itemcomplete', to: 'kitchen_staff_home#itemcomplete'
  post 'kitchenstaff/getnote',      to: 'kitchen_staff_home#getnote'

  get  'waitstaff',                 to: 'wait_staff_home#index'
  post 'waitstaff',                 to: 'wait_staff_home#index'
  post 'waitstaff/vieworders',      to: 'wait_staff_home#vieworders'
  post 'waitstaff/neworder',        to: 'wait_staff_home#neworder'
  post 'waitstaff/saveorder',       to: 'wait_staff_home#saveorder'
  post 'waitstaff/deleteorder',     to: 'wait_staff_home#deleteorder'
  post 'waitstaff/editorder',       to: 'wait_staff_home#editorder'
  get  'waitstaff/editorder',       to: 'wait_staff_home#editorder'

  get  'cashier',                   to: 'cashier_home#index'
  post 'cashier',                   to: 'cashier_home#index'
  post 'cashier/processpayment',    to: 'cashier_home#processpayment'

  get 'home/index'
  

  resources :menus

  resources :menu_items

  resources :customer_order_items

  resources :customer_orders

  resources :employee_tables

  resources :tables

  resources :employees

  resources :employee_types

  root 'home#index'

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
