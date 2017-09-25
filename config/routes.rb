Rails.application.routes.draw do
  get 'payments/new'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :products

    resources :categories

    resources :orders

    resources :order_items, only:[:create, :update, :destroy]

    resources :payments, only: [:new, :create]

    root 'categories#index'

    get '/shoppingcart' => 'orders#shoppingcart'

    get '/checkout' => 'orders#edit_order_shipping_address'

    patch '/checkout' => 'orders#update_order_shipping_address'

    patch '/payment' => 'orders#payment'

    patch '/confirm_order' => 'orders#confirm_order'

end
