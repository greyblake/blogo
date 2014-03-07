Rails.application.routes.draw do
  Blogo::Routes.mount_to(self, at: '/blog')
end
