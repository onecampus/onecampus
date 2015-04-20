Rails.application.routes.draw do
  root 'application#welcome'
  namespace :api do
    namespace :v1 do
      match 'users/register', to: 'users#register', via: :post  # 不需要任何权限
      match 'users/login', to: 'users#login', via: :post  # 不需要任何权限
      match 'users/:id/logout', to: 'users#logout', via: :delete  # 当前用户

      get 'users/:id' => 'users#show'  # 当前用户
      match 'users/avatar/uploader', to: 'users#avatar_uploader', via: :post  # 不需要任何权限
      match 'users/:id/avatar/update', to: 'users#update_avatar', via: :post  # 当前用户
      match 'users/:id/password/update', to: 'users#update_pass', via: :put  # 当前用户

      # twitter routes
      get 'users/twitters' => 'twitters#user_twitters'  # 当前用户, 用户自己的twitter
      get 'users/relation/twitters' => 'twitters#user_relation_twitters'  # 当前用户, 用户相关的twitter

      get 'universities' => 'universities#index'  # 不需要任何权限
    end
  end
end
