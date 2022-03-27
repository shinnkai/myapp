class HomeController < ApplicationController
  def top
    
  end
  
  def about
  end
  
  private

    def home_params
      params.require(:home).permit(:name, :tax_out_price, :image)
    end
  
end
