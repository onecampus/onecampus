class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	include ApplicationHelper

	before_action :set_locale
	before_action :set_current_user
	before_action :authenticate_request

	rescue_from NotAuthenticatedError do
		render json: { error: 'Not Authorized' }, status: :unauthorized
	end

	rescue_from AuthenticationTimeoutError do
		render json: { error: 'Auth token is expired' }, status: 419
	end

	rescue_from NoAuthTokenError do
		render json: { error: 'Auth token is not sent' }, status: 418
	end

	rescue_from ActiveRecord::RecordNotFound do
		render json: { error: 'Record not found' }, status: :not_found
	end

	layout false

	def method_missing
		render json: { error: '404' }, status: :not_found
	end

	protected

	# In Rails 4.2 and above for angular X-XSRF-TOKEN
	def verified_request?
		super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
	end

	private

	# Based on the user_id inside the token payload, find the user.
	def set_current_user
		@auth_token = http_auth_content
		unless @auth_token.blank?
			@current_user ||= User.where(auth_token: @auth_token).first
		end
	end

	def authenticate_request
		if !@current_user
			fail NotAuthenticatedError
		elsif auth_token_expired?
			fail AuthenticationTimeoutError
		end
	end

	def auth_token_expired?
		unless @current_user.blank?
			unless @current_user.expiration_time.blank?
				@current_user.expiration_time.to_i <= Time.now.to_i
			end
		else
			fail NotAuthenticatedError
		end
	end
end
