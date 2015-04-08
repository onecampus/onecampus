##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of users
class Api::V1::UsersController < ApplicationController
	skip_before_action :authenticate_request
	before_action :set_user, only: [:show, :update_avatar, :update_pass, :destroy]

	def index
		page = params[:page]
		per_page = params[:per_page]
		offset = params[:offset]
		@users = User.page(page).per(per_page).padding(offset).order('id DESC')
    data = { users: @users, total_count: User.all.count }
    render_success_json('User list.', :ok, data)
	end

	def show
    render_success_json('One user.', :ok, { user: @user })
	end

	def create
		@user = User.new(user_params)
		@user.password = User.hash_password @user.password
		@user.auth_token = User.generate_auth_token
		if @user.save
      render_success_json('User create success.', :created, { user: @user })
		else
      render_fail_json('User create fail.', :unprocessable_entity, { errors: @user.errors})
		end
	end

	def ajax_img_upload
		image = AvatarUploader.new
		image.store!(params[:file])
		return_hash = {
			state: 'success',
			url: image.url,
			title: image.filename
		}
    render_success_json('User create success.', :created, return_hash)
	end

	def update_avatar
		if @current_user.id != @user.id
      render_fail_json('Not current user.', :forbidden)
		else
			if @user.update user_params
				render json: { status: :avatar_updated }, status: :ok
			else
				render json: @user.errors, status: :unprocessable_entity
			end
		end
	end

	def update_pass
		if @current_user.id != @user.id
			render json: { error: 'Not current user' }
		else
			@user.password = User.hash_password user_params[:password]
			if @user.save
				render json: { status: :password_updated }, status: :ok
			else
				render json: @user.errors, status: :unprocessable_entity
			end
		end
	end

	def destroy
		if @user.destroy
      render_success_json('User destroied success.')
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:uid, :mobile, :email, :pass, :avatar)
	end
end