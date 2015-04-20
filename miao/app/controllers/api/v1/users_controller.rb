##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of users
class Api::V1::UsersController < ApplicationController
	# skip_before_action :authenticate_request
	before_action :set_user, only: [:show, :update_avatar, :update_pass, :destroy]

  # 用户列表
	def index  # FIXME: need test the pagination
		page = params[:page]
		per_page = params[:per_page]
		offset = params[:offset]
		@users = User.page(page).per(per_page).padding(offset).order('id DESC')
    data = { users: @users, total_count: User.all.count }
    render_success_json('User list.', :ok, data)
	end

  # 获取用户资料
	def show
    render_success_json('User info.', :ok, { user: @user })
	end

  def user_by_uid  # FIXME: test
    @user = User.where(uid: params[:uid])
    render_success_json('One user.', :ok, { user: @user })
  end

  def user_by_mobile  # FIXME: test
    @user = User.where(mobile: params[:mobile])
    render_success_json('One user.', :ok, { user: @user })
  end

  # 创建用户
	def create
		@user = User.new(user_params)
		@user.pass = User.hash_password @user.pass
		@user.access_token = User.generate_access_token
    @user.expiration_time = DateTime.now + 10.days
		if @user.save
      render_success_json('User create success.', :created, { user: @user })
		else
      render_fail_json('User create fail.', :unprocessable_entity, { errors: @user.errors })
		end
	end

  # 上传用户头像
	def avatar_uploader  # FIXME: test
		image = AvatarUploader.new
		image.store!(params[:avatar])
		data = {
			state: 'success',
			url: image.url,
			title: image.filename
		}
    render_success_json('User avatar create success.', :created, data)
	end

  # 更新用户头像
	def update_avatar  # FIXME: test
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

  # 关注某人
  # user_id
  def follow_user
    user_id = params[:user_id]
    if user_id && @current_user.id != user_id
      followabler = User.find user_id
      if @current_user.following? followabler
        render_fail_json('Already followed by current_user.', :unprocessable_entity)
      else
        @current_user.follow followabler
        render_success_json('User followed success.')
      end
    else
      render_fail_json('No user_id or can not follow self.', :unprocessable_entity)
    end
  end

  # 取消关注
  # user_id
  def un_follow
    user_id = params[:user_id]
    if user_id && @current_user.id != user_id
      follower = User.find user_id
      @current_user.stop_following follower
      render_success_json('User un followed success.')
    else
      render_fail_json('No user_id or can not un follow self.', :unprocessable_entity)
    end
  end

  # 同时关注一群人
  # user_ids
  def follow_users
    user_ids = params[:user_ids]
    user_ids.each do |user_id|
      follower = User.find user_id
      @current_user.stop_following follower
    end
    render_success_json('Users followed success.')
  end

  # 同时取消关注一群人
  # user_ids
  def follow_users
    user_ids = params[:user_ids]
    user_ids.each do |user_id|
      followabler = User.find user_id
      @current_user.follow followabler
    end
    render_success_json('Users followed success.')
  end

  # 获取所有我关注的人
  def follower_index
    my_followings = @current_user.all_follows
    render_success_json('User following.', :ok, { my_followings: my_followings })
  end

  # 获取所有关注我的人
  def followed_index
    my_followers = @current_user.followers
    render_success_json('User follower.', :ok, { my_followers: my_followers })
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
      :university_id,
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