class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	include ApplicationHelper

	before_action :set_locale
	before_action :set_current_user
	before_action :authenticate_request

	rescue_from NotAuthenticatedError do
    render_fail_json('Not Authorized.')
	end

	rescue_from AuthenticationTimeoutError do
    render_fail_json('Access token is expired.', 419, :token_expired)
	end

	rescue_from NoAuthTokenError do
    render_fail_json('Access token is not sent.', 418, :none_token)
	end

	rescue_from ActiveRecord::RecordNotFound do
    render_fail_json('Record not found.', 404, :not_found)
	end

	layout false

	def method_missing
    render_fail_json('Not found.', 404, :not_found)
	end

	private

	def set_current_user
	  @access_token = http_access_content
	  unless @access_token.blank?
	    @current_user ||= User.where(access_token: @access_token).first
	  end
	end

	def authenticate_request
	  if !@current_user
	    fail NotAuthenticatedError
	  elsif access_token_expired?
		  fail AuthenticationTimeoutError
	  end
	end
end
