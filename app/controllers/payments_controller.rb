class PaymentsController < ApplicationController

  before_action :check_cart
  before_action :check_stock
  before_action :check_shipping_address

  def new
  	gon.client_token = generate_client_token
  end

  def create
  	fail
  	@order = current_order
  	@result = Braintree::Transaction.sale(
              amount: @order.total,
              payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      session[:order_id] = nil
      @order.update(status: "placed")
      flash[:success] = "Congraulations! Your order has been placed successfully!"
      redirect_to root_url
    else
      flash[:danger] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private
  def generate_client_token
  	Braintree::ClientToken.generate
  end
end
