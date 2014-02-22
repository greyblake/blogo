Blogo::Engine.routes.draw do

  namespace :admin do
    get "/" => "posts#index", as:  "" # responds to admin_url and admin_path
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new", as: 'login'
    resources :sessions, only: %i(new create destroy)
    resources :posts
    resources :users
  end


  root to: "posts#index"
  get '/page/:page' =>  'posts#index', as: 'page'

  get ":year/:post_url" => "posts#show", as:  "post"
end
