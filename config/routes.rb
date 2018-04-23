Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_for :users, :controllers => {
  #   :sessions => "users/sessions",
  #   :registrations => "users/registrations",
  #   :passwords => "users/passwords",
  #   :omniauth_callbacks => "users/omniauth_callbacks"
  # }

  root 'place#index'

  namespace :place do
    #get 'place/list' request
    get 'list'
  end

  resources :place, :only => [ :index, :show, :create, :destroy ]
  resources :reviews, :only => [ :index, :show, :new, :create, :destroy ]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
