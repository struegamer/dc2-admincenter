Dc2Admin::Application.routes.draw do
  get "home/index"

  root :to => "home#index"

  namespace :admin do
    resources :main
    resources :users
    resources :dcbackends
    resources :kvms
    resources :interface_types
    resources :inet_types
  end
  match "/admin" => "admin/main#index"


  resources :datactrls do
    collection do
      get "interfaces_new"
    end
  end

  # match "/datactrls/interfaces_new" => "datactrls#interfaces_new"

  resources :stats
  match "/stats/servers/:backend_id" => "stats#servers"
  match "/stats/kvms" => "stats#kvms"

  resources :sessions
  match "/login" => "sessions#new"
  match "/logout" => "sessions#destroy"

  namespace :backends do
    resources :main
    resources :servers
  end


end
