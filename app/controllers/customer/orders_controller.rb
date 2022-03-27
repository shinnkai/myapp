class Customer::OrdersController < ApplicationController
  # def new
  #   if CartItem.exists?(customer_id: current_customer.id)
  #     @order = Order.new
  #   else
  #     redirect_to items_path
  #   end
  # end

    def new
    @cart = CartItem.all.where(customer: current_customer)
      if @cart.empty?
      redirect_to cart_items_path, notice: 'cart is empty.'
      end

    @order = Order.new
    @shipping_addresses = ShippingAddress.where(customer: current_customer)
    end



  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.item_id = cart_item.item_id

      #購入時価格
      @order_items.subprice = cart_item.item.tax_out_price
      @order_items.quantity = cart_item.quantity
      @order_items.order_id = @order.id
      @order_items.save
    end
    current_customer.cart_items.destroy_all
    redirect_to thanx_orders_path
  end

  def logs
    @cart_items = CartItem.all
    @customer = current_customer
    @total_payment = 0

    @cart_items.each do |cart_item|
    @total_payment += ((cart_item.item.tax_out_price * cart_item.quantity) * 1.1).floor
    end

    @order = Order.new(order_params)
    @postage = 600
    @order.total_payment = @total_payment + 600

    if params[:order][:address_number] == "1"
      @order.name = current_customer.family_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code

    elsif params[:order][:address_number] == "2"
      @address = ShippingAddress.find_by(customer_id: current_customer.id)
      @order.name = @address.name
      @order.address = @address.address
      @order.postal_code = @address.postal_code
    else params[:order][:select_address] = "3"
      @order.name = params[:order][:name]
      @order.address = params[:order][:address]
      @order.postal_code = params[:order][:postal_code]
    end
  end

  def index
    @orders = Order.order(created_at: :desc).page(params[:page]).per(8)
    # @orders = Order.all
    @order = current_customer
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @postage = 600
    @total_payment = 0
    @order_items.each do |order_items|
      @total_payment += ((order_items.item.tax_out_price*order_items.quantity)*1.1).floor
    end
  end

  def thanx
  end


  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :payment_method, :total_payment, :address ,:customer_id, :postage)
  end
end
