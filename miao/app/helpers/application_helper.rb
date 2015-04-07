# All app helper
#
module ApplicationHelper

  def http_access_content
    return @http_access_token if defined? @http_access_token
    @http_access_token = begin
      if params[:access_token].present?
        params[:access_token]
      elsif request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      else
        fail NoAuthTokenError
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def access_token_expired?
    unless @current_user.blank?
      unless @current_user.expiration_time.blank?
        @current_user.expiration_time.to_i <= Time.now.to_i
      end
    else
      fail NotAuthenticatedError
    end
  end
end