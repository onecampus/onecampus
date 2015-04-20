##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of access
class Api::V1::AccessController < ApplicationController
	skip_before_action :authenticate_request, only: [:login, :register]

  # 用户登录
	def login
		user = User.authentication(login_params[:mobile], login_params[:pass])
		if user
			touch_exp_time user  # 更新token过期时间
      touch_last_login user, request.remote_ip  # 更新最后一次登录的ip和时间
      user.save!
      data = { access_token: user.access_token,
               expiration_time: user.expiration_time,
               current_user: user }
      render_success_json('Login success.', :ok, data)
		else
      render_fail_json('Invalid mobile or password.')
		end
	end

  # 用户注册
  def register
    u_flag = already_exist_user?(register_params[:mobile])
    if u_flag
      render_fail_json('Already registered.', :already_registered)
    else
      u = User.new(register_params)
      u.pass = User.hash_password u.pass
      u.access_token = User.generate_access_token
      u.expiration_time = DateTime.now + 10.days
      u.salt = 'flowerwrong'
      if u.save  # 第一次创建后自动添加miao角色
        render_success_json('User registered success.', :created, { user: u })
      else
        render_fail_json('User registered fail.', :unprocessable_entity, { errors: u.errors})
      end
    end
  end

  # 用户退出
	def logout
    @current_user.access_token = User.generate_access_token
    if @current_user.save!
      render_success_json('Logout success.')
    else
      render_error_json('Logout fail.')
    end
	end

	private

  def already_exist_user?(mobile)
    User.where(mobile: mobile).first.blank? ? false : true
  end

	def login_params
		params.require(:login).permit(:mobile, :pass)
	end

  def register_params
    params.require(:register).permit(:mobile, :pass)
  end

  # 延长用户token存活期
	def touch_exp_time(user)
		user.expiration_time = (DateTime.now + 10.days) if user.expiration_time.to_i <= Time.now.to_i
	end

  # 更新用户最后一次登录的资料
  def touch_last_login(user, ip)
    user.last_login_ip = ip
    user.last_sign_in_at = DateTime.now
  end
end
