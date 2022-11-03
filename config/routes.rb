Rails.application.routes.draw do

  resources :orders
  get 'welcome/index'
  root 'welcome#index'
  
  api_version(:module => "V1", :path => {:value => "api/v1"}) do
    resources :products, only: [:index, :show, :create]
    
    resources :inventory_centers do
      resource :products, only: [:show]
      resource :orders, only: [:show]
      
      resource :product, only: [:show, :update, :create, :destroy]
      resource :order, only: [:show, :update, :create, :destroy]
    end

    resources :orders do
      resource :products, only: [:show]
      resource :inventory_centers, only: [:show]
      
      resource :product, only: [:show, :update, :create, :destroy]
      resource :inventory_center, only: [:show, :update, :create, :destroy]
    end

    resources :products do
      resource :orders, only: [:show]
      resource :inventory_centers, only: [:show]
      
      resource :order, only: [:show, :update, :create, :destroy]
      resource :inventory_centers, only: [:show, :update, :create, :destroy]
    end
    
  end
end
