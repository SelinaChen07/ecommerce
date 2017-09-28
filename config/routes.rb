Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :products

    resources :categories

    resources :orders
    get '/confirm_order' => 'orders#confirm_order'
    
    resources :order_items, only:[:create, :update, :destroy]

    resource :shoppingcart, only:[:show,:destroy]

    namespace :checkout do
        resource :shipping_address, only:[:new, :create, :edit, :update ]
    end

    resources :payments, only: [:new, :create]

    root 'categories#index'    

end
