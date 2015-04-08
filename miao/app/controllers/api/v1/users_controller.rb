##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of users
class Api::V1::UsersController < ApplicationController
	# skip_before_action :authenticate_request
	before_action :set_user, only: [:show, :update_avatar, :update_pass, :destroy]

  # 用户列表
	def index
		page = params[:page]
		per_page = params[:per_page]
		offset = params[:offset]
		@users = User.page(page).per(per_page).padding(offset).order('id DESC')
    data = { users: @users, total_count: User.all.count }
    render_success_json('User list.', :ok, data)
	end

  # 获取用户资料
	def show
    render_success_json('One user.', :ok, { user: @user })
	end

  # 创建用户
	def create
		@user = User.new(user_params)
		@user.pass = User.hash_password @user.pass
		@user.access_token = User.generate_access_token
		if @user.save
      render_success_json('User create success.', :created, { user: @user })
		else
      render_fail_json('User create fail.', :unprocessable_entity, { errors: @user.errors})
		end
	end

  # 上传用户头像, no test
	def avatar_uploader
		image = AvatarUploader.new
		image.store!(params[:avatar])
		data = {
			state: 'success',
			url: image.url,
			title: image.filename
		}
    render_success_json('User avatar create success.', :created, data)
	end

  # 更新用户头像, no test
	def update_avatar
		if @current_user.id != @user.id
      render_fail_json('Not current user.', :forbidden)
		else
			if @user.update user_params
        render_success_json('User avatar success.', :ok)
			else
        render_fail_json('User avatar update fail.', :unprocessable_entity, { errors: @user.errors})
			end
		end
	end

  # 更新用户密码
	def update_pass
		if @current_user.id != @user.id
      render_fail_json('Not current user.', :forbidden)
		else
			@user.pass = User.hash_password user_params[:pass]
			if @user.save
        render_success_json('User pass update success.')
			else
        render_fail_json('User pass update fail.', :unprocessable_entity, { errors: @user.errors})
			end
		end
	end

  # 删除用户
	def destroy
		if @user.destroy
      render_success_json('User destroied success.')
		else
      render_fail_json('User destroy fail.', :unprocessable_entity, { errors: @user.errors})
		end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(
      :last_name,
      :first_name,
      :nick_name,
      :uid,
      :pass,
      :avatar,
      :email,
      :age,
      :university,
      :address_current,
      :birthday,
      :tel,
      :mobile,
      :gender,
      :language,
      :personalized_signature,
      :country,
      :province,
      :city,
      :region,
      :postcode
    )
	end
end