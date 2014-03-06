# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>

RailsBootstrap::Application.routes.draw do

  devise_for :users, :path_prefix => 'auth'

  authenticated :user do
    root :to => 'reports#dashboard', as: :authenticated_root
  end
  unauthenticated do
    root :to => 'pages#index'
  end


  # Páginas Públicas
  get 'terms', to: 'pages#terms'


  # Relatórios
  get 'dashboard', to: 'reports#dashboard'

  resources :users do
    member do
      get :edit_password
      patch :update_password
    end
  end
  resources :companies



  match "*path", :to => "application#routing_error", :via => :all

end
