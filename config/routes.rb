Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :products

    resources :categories

    resources :orders

    resources :order_items, only:[:create, :update, :destroy]

    root 'categories#index'

    get '/shoppingcart' => 'orders#shoppingcart'

    get '/checkout' => 'orders#checkout'

    patch '/confirm_order' => 'orders#confirm_order'

end
