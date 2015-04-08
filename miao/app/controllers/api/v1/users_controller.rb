##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of users
class Api::V1::UsersController < ApplicationController
	# skip_before_action :authenticate_request, only: [:ajax_img_upload]
	before_action :set_user, only: [:show, :update_avatar, :update_pass, :destroy]

	def index
		page = params[:page]
		per_page = params[:per_page]
		offset = params[:offset]
		@users = User.page(page).per(per_page).padding(offset).order('id DESC')
    render  json: {
              status: 'success',
              code: 200,
              msg: 'User list.',
              data: { users: @users, total_count: User.all.count },
              links: {}
            }, status: 200
	end

	def show
    render_success_json('One user.', { user: @user })
	end

	def create
		@user = User.new(user_params)
		@user.password = User.hash_password @user.password
		@user.auth_token = User.generate_auth_token
		if @user.save
			render json: { status: :created }, status: :ok
		else
			render json: @user.errors, status: :unprocessable_entity
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
		render json: return_hash, status: :ok
	end

	def update_avatar
		if @current_user.id != @user.id
			render json: { error: 'Not current user' }
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
			render json: { status: :destroied }
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