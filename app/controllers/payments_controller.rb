class PaymentsController < ApplicationController

  before_action :check_cart,only:[:new]
  before_action :check_stock,only:[:new]
  before_action :check_shipping_address,only:[:new]

  def new
  	@client_token = Braintree::ClientToken.generate
    @order = current_order
    @order.update(status: "starting payment")
    @order_items = @order.order_items
  end

  def create
    @order = current_order
  	@result = Braintree::Transaction.sale(
              amount: @order.total,
              payment_method_nonce: params[:payment_method_nonce],
               :options => {:submit_for_settlement => true}
    )

    if @result.success?
      session[:order_id] = nil
      transaction_id = @result.transaction.id
      confirmation_num = 276995 + @order.id
      @order.update(status: "placed", reserve_stock:false, transaction_id: transaction_id, confirmation_num: confirmation_num)
      update_stock
      redirect_to payment_path(confirmation_num)
    else
      flash.now[:danger] = "Something went wrong while processing your transaction. Please try again!"
      @client_token = Braintree::ClientToken.generate
      @order.update(status: "payment failed")
      @order_items = @order.order_items
      render :new
    end
  end

  def show
    @confirmation_num = params[:id]
  end

  private

  def update_stock
    @order.order_items.each do |order_item|
      new_stock = order_item.product.stock - order_item.product_quantity
      order_item.product.update(stock: new_stock)
    end
  end

end
