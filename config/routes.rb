Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => "users/registrations",
    :passwords => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :users, :only => [:index, :show]

  root 'places#index'

  namespace :places do
    #get 'place/list' request
    get 'list'
  end

  resources :places, :only => [ :index, :show, :create, :destroy ]
  resources :reviews, :only => [ :index, :show, :new, :create, :destroy ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
