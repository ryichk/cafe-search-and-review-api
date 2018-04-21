Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'place#index'

  namespace :place do
    #get 'place/list' request
    get 'list'
  end

  resources :place, :only => [ :index, :show, :create, :destroy ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
