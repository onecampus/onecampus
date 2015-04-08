##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of access
class Api::V1::AccessController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]
	def create
		user = User.authentication(login_params[:mobile], login_params[:pass])
		if user
			touch_exp_time user
      render  json: {
                status: 'success',
                code: 200,
                msg: 'Login success.',
                data: { access_token: user.access_token,
                        expiration_time: user.expiration_time,
                        current_user: user },
                links: {}
              }, status: 200
		else
      render json:  {
              status: 'error',
              code: 401,
              msg: 'Invalid mobile or password.',
              data: nil,
              links: {}
            }, status: :unauthorized
		end
	end

	def destroy
    @current_user.access_token = User.generate_access_token
    if @current_user.save!
      render  json: {
                status: 'success',
                code: 200,
                msg: 'Logout success.',
                data: nil,
                links: {}
              }, status: 200
    else
      render json:  {
              status: 'error',
              code: 501,
              msg: 'Logout fail.',
              data: nil,
              links: {}
            }, status: 501
    end
	end

	private

	def login_params
		params.require(:login).permit(:mobile, :pass)
	end

	def touch_exp_time(user)
		if user.expiration_time.to_i <= Time.now.to_i
  		user.expiration_time = DateTime.now + 10.days
  		user.save!
    end
	end
end
