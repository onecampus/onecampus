class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	include ApplicationHelper

	before_action :set_locale
	before_action :set_current_user
	before_action :authenticate_request

	rescue_from NotAuthenticatedError do
    render_fail_json(401, 'Not Authorized.')
	end

	rescue_from AuthenticationTimeoutError do
    render_fail_json(419, 'Access token is expired.')
	end

	rescue_from NoAuthTokenError do
    render_fail_json(418, 'Access token is not sent.')
	end

	rescue_from ActiveRecord::RecordNotFound do
    render_fail_json(404, 'Record not found.')
	end

	layout false

	def method_missing
    render_fail_json(404, 'Not found.')
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
