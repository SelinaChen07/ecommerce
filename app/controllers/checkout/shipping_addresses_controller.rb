class Checkout::ShippingAddressesController < ApplicationController
  before_action :check_cart, only:[:new]
  before_action :check_stock, only:[:new]

  def new
  	@shipping_address = ShippingAddress.new
  end

  def edit
  	@shipping_address = current_order.shipping_address
  	redirect_to new_checkout_shipping_address_path if @shipping_address.nil?
  	render "new"
  	#The view file for edit is exactly the same as new, except for the value of @shipping_address.
  end

  def create

    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      current_order.update(shipping_address_id: @shipping_address.id)
      redirect_to new_payment_path
    else
      render "new" 
    end
  end

  def update
    @shipping_address = current_order.shipping_address
    if @shipping_address.update(shipping_address_params)
      redirect_to new_payment_path
    else
      render "edit" 
    end
  end

  private
  def shipping_address_params
    params.require(:shipping_address).permit(:firstname, :lastname, :phone, :email, :level_or_suite, :street_address, :city, :state, :contry, :postcode)
  end

end
