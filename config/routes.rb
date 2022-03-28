Rails.application.routes.draw do

  root to: 'home#top'
   get '/about' => 'home#about'

  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   devise_for :customers, controllers: {
     registrations: 'customer/registrations',
     sessions: 'customer/sessions'
  }

  

  # 管理者側のルートはurlにadminがつく
  # namespace :admin do
  #   resources :customers, only: [:index, :show, :edit, :update]
  #   resources :orders, only: [:index, :show, :update]
  #   resources :items
  #   resources :cart_items
  # end

  # 顧客側のルートはurlにcustomerがつかない
  scope module: :customer do
    resources :customers, only: [:show, :edit, :update] do
      collection do
        patch 'delete'
        get 'confirm_delete'
      end
    end
    resources :shipping_addresses, only: [:index, :edit ,:create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :destroy, :update] do
      collection do
        delete :destroy_all
      end
    end
    resources :order_items
    resources :orders do
      collection do
        post :logs
        get :thanx
      end
    end


  end

end
