Dc2Admin::Application.routes.draw do
  get "home/index"

  root :to => "home#index"

  namespace :admin do
    resources :main
    resources :users
    resources :dcbackends
  end
  match "/admin" => "admin/main#index"

  resource :stats
  match "/stats/servers/:backend_id" => "stats#servers"

  resources :sessions
  match "/login" => "sessions#new"
  match "/logout" => "sessions#destroy"

  namespace :backends do
    resources :main
    resources :servers
    match "servers/:backend_id" => "servers#index"
  end


end
