class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:first_name, :family_name, :kana_first_name, :kana_family_name, :address, :postal_code, :tel])
  end
  
  before_action :authenticate_customer!, if: :customer_url

  def customer_url
    request.fullpath.include?("/customers") && request.fullpath.exclude?("/admin")
  end
  
end
