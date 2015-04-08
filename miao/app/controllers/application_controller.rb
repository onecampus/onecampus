class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	include ApplicationHelper

	before_action :set_locale
	before_action :set_current_user
	before_action :authenticate_request

	rescue_from NotAuthenticatedError do
	  render  json: {
  					  status: 'error',
  					  code: 401,
  					  msg: 'Not Authorized.',
  					  data: nil,
  					  links: {}
  					}, status: :unauthorized
	end

	rescue_from AuthenticationTimeoutError do
	  render  json: {
  					  status: 'error',
  					  code: 419,
  					  msg: 'Access token is expired.',
  					  data: nil,
  					  links: {}
  					}, status: 419
	end

	rescue_from NoAuthTokenError do
	  render  json: {
  					  status: 'error',
  					  code: 418,
  					  msg: 'Access token is not sent.',
  					  data: nil,
  					  links: {}
  					}, status: 418
	end

	rescue_from ActiveRecord::RecordNotFound do
	  render  json: {
  					  status: 'error',
  					  code: 404,
  					  msg: 'Record not found.',
  					  data: nil,
  					  links: {}
  					}, status: :not_found
	end

	layout false

	def method_missing
	  render  json: {
  					  status: 'error',
  					  code: 404,
  					  msg: 'Not found.',
  					  data: nil,
  					  links: {}
  					}, status: :not_found
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
