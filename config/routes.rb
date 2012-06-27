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
    namespace :assetmgmt do
      resources :main
      resources :cabinets
      resources :locations
      resources :dc_modules
    end
  end
  match "/admin" => "admin/main#index"


  resources :datactrls do
    collection do
      get "interfaces_new"
    end
    collection do
      get "get_hw_interfaces"
    end
    collection do
      get "get_class_templates"
    end
    collection do 
      get 'get_defaultclasses'
    end
  end

  # match "/datactrls/interfaces_new" => "datactrls#interfaces_new"

  resources :stats
  match "/stats/servers/:backend_id" => "stats#servers"
  match "/stats/hosts/:backend_id" => "stats#hosts"
  match "/stats/kvms" => "stats#kvms"
  match "/stats/deployment/:backend_id" => 'stats#deployment'

  resources :sessions
  match "/login" => "sessions#new"
  match "/logout" => "sessions#destroy"

  namespace :backends do
    resources :main
    resources :servers
    resources :hosts
    resources :deployments
  end


end
