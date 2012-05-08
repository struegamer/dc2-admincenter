Dc2Admin::Application.routes.draw do
  get "home/index"

  root :to => "home#index"

  namespace :admin do
    resources :main
    resources :users
    resources :dcbackends
  end
  match "/admin" => "admin/main#index"


  resources :sessions
  match "/login" => "sessions#new"
  match "/logout" => "sessions#destroy"

  resources :backends
  match "/backends/(/:backend_id)/servers/(/:server_action)" => "backends#servers"

end
