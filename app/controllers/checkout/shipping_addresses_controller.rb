class Checkout::ShippingAddressesController < ApplicationController
  before_action :check_cart
  before_action :check_stock
  before_action :if_address_exist, only:[:new, :create]
  before_action :if_address_not_exist, only:[:edit, :update]

  def new
  	@shipping_address = ShippingAddress.new
    current_order.update(status: "filling in shipping address")
  end

  def edit
    order = current_order
  	@shipping_address = order.shipping_address
    order.update(status: "editing shipping address")
  	render "new"
  	#The view file for edit is exactly the same as new, except for the value of @shipping_address.
  end

  def create

    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      current_order.update(shipping_address_id: @shipping_address.id, status: "finish creating shipping address")
      redirect_to new_payment_path
    else
      render "new" 
    end
  end

  def update
    order = current_order
    @shipping_address = order.shipping_address
    if @shipping_address.update(shipping_address_params)
      order.update(status: "finish editing shipping address")
      redirect_to new_payment_path
    else
      render "new" 
    end
  end

  private
  def shipping_address_params
    params.require(:shipping_address).permit(:firstname, :lastname, :phone, :email, :level_or_suite, :street_address, :suburb_or_city, :state, :contry, :postcode)
  end

  def if_address_exist
  	redirect_to edit_checkout_shipping_address_path if !current_order.shipping_address.nil?
  end

  def if_address_not_exist
  	redirect_to new_checkout_shipping_address_path if current_order.shipping_address.nil?
  end

end
