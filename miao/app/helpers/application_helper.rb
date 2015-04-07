# All app helper
#
module ApplicationHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def require_login
    unauthenticated unless current_user
  end

  def unauthenticated
    render text: 'unauthenticated', status: :unauthorized
  end

  def http_auth_content
    return @http_auth_token if defined? @http_auth_token
    @http_auth_token = begin
      if params[:auth_token].present?
        params[:auth_token]
      elsif request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      else
        # fail NoAuthTokenError
        nil
      end
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end