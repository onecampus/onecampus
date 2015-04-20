Rails.application.routes.draw do
  root 'application#welcome'
  namespace :api do
    namespace :v1 do
      match 'users/register', to: 'users#register', via: :post
      match 'users/login', to: 'users#login', via: :post
      match 'users/:id/logout', to: 'users#logout', via: :delete

      get 'users/:id' => 'users#show'
      match 'users/avatar/uploader', to: 'users#avatar_uploader', via: :post
      match 'users/:id/avatar/update', to: 'users#update_avatar', via: :post
      match 'users/:id/password/update', to: 'users#update_pass', via: :put

      # twitter routes
      get 'twitters' => 'twitters#index', as: :index_twitters_api
      get 'users/twitters' => 'twitters#user_twitters'
      get 'users/relation/twitters' => 'twitters#user_relation_twitters'

      get 'universities' => 'universities#index'
    end
  end
end
