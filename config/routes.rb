Blogo::Engine.routes.draw do

  namespace :admin do
    get "/" => "posts#index", as:  "" # responds to admin_url and admin_path
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new", as: 'login'
    resources :sessions, only: %i(new create destroy)
    resources :posts
    resources :users
    resources 'comments', only: %w(index)
    resources 'images'  , only: %w(create)
  end

  root to: "posts#index"
  get '/page/:page' =>  'posts#index', as: 'page'
  get '/tag/:tag' => 'posts#index', as: 'tag'
  get '/tag/:tag/page/:page' => 'posts#index', as: 'tag_page'

  get '/feed' => 'posts#feed', as: 'feed', defaults: { format: 'atom' }


  get ":year/:post_url" => "posts#show", as:  "post"
end
