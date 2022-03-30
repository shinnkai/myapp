class Customer::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    #カートに追加するため
    @cart_items = CartItem.new
    
  end


  private

  def item_params
    params.require(:item).permit(:name, :explanation, :tax_out_price, :image)
  end

  
end