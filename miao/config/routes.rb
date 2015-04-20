Rails.application.routes.draw do
  root 'application#method_missing'
  namespace :api do
    namespace :v1 do
      match 'users/register', to: 'users#register', via: :post
      match 'users/login', to: 'users#login', via: :post
      match 'users/logout', to: 'users#logout', via: :delete

      # get 'users' => 'users#index', as: :index_users_api
      get 'users/:id' => 'users#show'
      # match 'users/create', to: 'users#create', via: :post
      match 'users/avatar/uploader', to: 'users#avatar_uploader', via: :post
      match 'users/:id/avatar/update', to: 'users#update_avatar', via: :post
      match 'users/:id/password/update', to: 'users#update_pass', via: :put
      # match 'users/:id/destroy', to: 'users#destroy', via: :delete

      # twitter routes
      get 'twitters' => 'twitters#index', as: :index_twitters_api
      get 'user/twitters' => 'twitters#user_twitters'
      get 'user/relation/twitters' => 'twitters#user_relation_twitters'

      get 'universities' => 'universities#index'
    end
  end
end
