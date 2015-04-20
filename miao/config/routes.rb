Rails.application.routes.draw do
  root 'application#welcome'
  namespace :api do
    namespace :v1 do
      match 'users/register', to: 'users#register', via: :post  # 不需要任何权限
      match 'users/login', to: 'users#login', via: :post  # 不需要任何权限
      match 'users/:id/logout', to: 'users#logout', via: :delete  # 当前用户

      get 'users/:id' => 'users#show'  # 当前用户
      match 'users/avatar/uploader', to: 'users#avatar_uploader', via: :post  # 不需要任何权限
      match 'users/:id/avatar/update', to: 'users#update_avatar', via: :put  # 当前用户
      match 'users/:id/password/update', to: 'users#update_pass', via: :put  # 当前用户

      # twitter routes
      get 'users/:id/twitters' => 'twitters#user_twitters'  # 当前用户, 用户自己的twitter
      get 'users/:id/relation/twitters' => 'twitters#user_relation_twitters'  # 当前用户, 用户相关的twitter
      match 'users/:id/twitters', to: 'twitters#create', via: :post  # 当前用户, 创建twitter
      get 'twitters/:id' => 'twitters#show'  # 所有用户, 包含未登录用户
      match 'users/:user_id/twitters/:twitter_id', to: 'twitters#update', via: :put  # 当前用户, 更新twitter
      match 'users/:user_id/twitters/:twitter_id', to: 'twitters#destroy', via: :delete  # 当前用户, 删除twitter

      # picture routes
      match 'users/:id/pictures/uploader', to: 'pictures#picture_uploader', via: :post  # 当前用户

      get 'universities' => 'universities#index'  # 不需要任何权限
    end
  end
end
