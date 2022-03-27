class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
     @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render "edit"
    end
  end
  
  def delete
    @customer = current_customer
    @customer.update(status: false)
    reset_session
    flash[:notice] = "Thanyou for using this site ！"
    redirect_to root_path
  end
  
  def confirm_delete
    @customer = current_customer
  end


  private

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :kana_family_name, :kana_first_name, :postal_code, :address, :tel, :email, :status)
  end

end
