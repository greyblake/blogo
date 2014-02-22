Rails.application.routes.draw do
  mount Blogo::Engine, at: '/blog'
end
