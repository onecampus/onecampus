class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

  # check_authorization  # ensure authorization happens on every action in your application
  # skip_authorization_check

  layout false

  def welcome
    render josn: { msg: 'welcome to my world.' }
  end

	include ApplicationHelper

	before_action :set_locale
	before_action :current_user
	before_action :authenticate_request

  # 授权错误, for cancancan
  rescue_from CanCan::AccessDenied do |exception|
    render_fail_json(exception.message)
  end

  # 401 未授权
	rescue_from NotAuthenticatedError do
    render_fail_json('Not Authorized.')
	end

  # 419 token过期
	rescue_from AuthenticationTimeoutError do
    render_fail_json('Access token is expired.', :token_expired)
	end

  # 418 token未发送
	rescue_from NoAuthTokenError do
    render_fail_json('Access token is not sent.', :none_token)
	end

  # 404 记录未找到
	rescue_from ActiveRecord::RecordNotFound do
    render_fail_json('Record not found.', :not_found)
	end

	private

  # 判断用户是否登录，token是否过期
	def authenticate_request
	  if @current_user.blank?
	    fail NotAuthenticatedError
	  elsif access_token_expired?
		  fail AuthenticationTimeoutError
	  end
	end
end
