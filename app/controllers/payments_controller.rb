class PaymentsController < ApplicationController

  before_action :check_cart
  before_action :check_stock
  before_action :check_shipping_address

  def new
  	gon.client_token = generate_client_token
    @order = current_order
    @order.update(status: "starting payment")
    @order_items = @order.order_items
  end

  def create
  	@order = current_order
  	@result = Braintree::Transaction.sale(
              amount: @order.total,
              payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      session[:order_id] = nil
      @order.update(status: "placed")
      redirect_to confirm_order_path
    else
      flash[:danger] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      @order.update(status: "payment failed")
      render :new
    end
  end

  private
  def generate_client_token
  	Braintree::ClientToken.generate
  end
end
