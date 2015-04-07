Rails.application.routes.draw do
  root 'application#method_missing'
  namespace :api do
    namespace :v1 do
      match 'users/auth', to: 'access#create', via: :post
      match 'users/destroy', to: 'access#destroy', via: :delete

      get 'users' => 'users#index', as: :index_user_api
      get 'users/:id' => 'users#show'
      match 'users/create', to: 'users#create', via: :post
      match 'users/image/uploader', to: 'users#ajax_img_upload', via: :post
      match 'users/:id/avatar/update', to: 'users#update_avatar', via: :post
      match 'users/:id/password/update', to: 'users#update_pass', via: :put
      match 'users/:id/destroy', to: 'users#destroy', via: :delete
    end
  end
end
