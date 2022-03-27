class Customer::CartItemsController < ApplicationController
  def index
    @cart_items = my_cart
    @total_price = 0
    @total = @cart_items.sum{|cart_item|cart_item.item.tax_out_price.to_i * cart_item.quantity.to_i * 1.1}
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if my_cart.find_by(item_id: params[:cart_item][:item_id]).present?
			item_in_cart = my_cart.find_by(item_id: params[:cart_item][:item_id])
			item_in_cart.quantity += params[:cart_item][:quantity].to_i
			item_in_cart.save
      flash[:notice] = '商品を追加でカートに入れました。'
      redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice] = '商品をカートに入れました。'
      redirect_to cart_items_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to item_path(params[:item_id])
    ender_cart_items_path

    end

  end


  def update
    @cart_item = my_cart.find_by(id: params[:id])

    if @cart_item.update(quantity: params[:quantity].to_i)
      flash[:notice] = 'カート内の内容が更新されました'
    else
      flash[:alert] = 'カート内の内容の更新に失敗しました'
    end
    redirect_to request.referer
  end






def destroy

   #@cart_item = CartItem.find(params[:id])

    @cart_item = my_cart.find_by(id: params[:id])

    if @cart_item.destroy
      flash[:notice] = 'カート内の内容が削除されました'
    else
      flash[:alert] = 'カート内の内容の削除に失敗しました'
    end
    redirect_to request.referer

  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end


  private

  def my_cart
    current_customer.cart_items
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
