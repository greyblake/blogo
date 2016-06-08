module Blogo
  module Routes
    def self.mount_to(context, opts)
      blog_scope = opts[:at] || '/blogo'

      context.instance_eval do
        scope(path: blog_scope, module: 'blogo', as: 'blogo') do
          namespace :admin do
            # blogo_admin_path
            get "/" => "posts#index", as:  ""
            get "logout" => "sessions#destroy"
            get "login" => "sessions#new", as: 'login'

            post  '/posts/preview' => 'posts#preview', as: :post_preview
            patch '/posts/preview' => 'posts#preview'

            resources :sessions, only: %w(new create destroy)
            resources :posts, except: %w(show)
            resources :users
            resources 'comments', only: %w(index)
            resources 'images'  , only: %w(create)
          end

          get '/'                    => 'posts#index', as: 'root'
          get '/:archives'           => 'posts#index', as: 'archives'
          get '/page/:page'          => 'posts#index', as: 'page'
          get '/tag/:tag'            => 'posts#index', as: 'tag'
          get '/tag/:tag/page/:page' => 'posts#index', as: 'tag_page'
          get '/feed'                => 'posts#feed' , as: 'feed', defaults: { format: 'atom' }
          get ':permalink'          => 'posts#show' , as: 'post'
        end
      end
    end
  end
end
