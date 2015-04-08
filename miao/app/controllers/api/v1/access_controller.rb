##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of access
class Api::V1::AccessController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]

  # 用户登录
	def create
		user = User.authentication(login_params[:mobile], login_params[:pass])
		if user
			touch_exp_time user
      data = { access_token: user.access_token,
               expiration_time: user.expiration_time,
               current_user: user }
      render_success_json('Login success.', :ok, data)
		else
      render_fail_json('Invalid mobile or password.')
		end
	end

  # 用户退出
	def destroy
    @current_user.access_token = User.generate_access_token
    if @current_user.save!
      render_success_json('Logout success.')
    else
      render_error_json('Logout fail.')
    end
	end

	private

	def login_params
		params.require(:login).permit(:mobile, :pass)
	end

  # 延长用户token存活期
	def touch_exp_time(user)
		if user.expiration_time.to_i <= Time.now.to_i
  		user.expiration_time = DateTime.now + 10.days
  		user.save!
    end
	end
end
