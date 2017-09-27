Rails.application.routes.draw do
  namespace :checkout do
    get 'shipping_addresses/new'
  end

  namespace :checkout do
    get 'shipping_addresses/edit'
  end

  get 'payments/new'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :products

    resources :categories

    resources :orders
    get '/shoppingcart' => 'orders#shoppingcart'

    resources :order_items, only:[:create, :update, :destroy]

    namespace :checkout do
        resource :shipping_address, only:[:new, :create, :edit, :update ]
    end

    resources :payments, only: [:new, :create]

    root 'categories#index'    
    
    patch '/confirm_order' => 'orders#confirm_order'

end
