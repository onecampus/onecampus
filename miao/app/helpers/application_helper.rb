# All app helper
#
module ApplicationHelper
  # 获取用户发送的access_token
  def http_access_content
    return @http_access_token if defined? @http_access_token
    @http_access_token = begin
      if params[:access_token].present?
        params[:access_token]
      elsif request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      else
        nil
      end
    end
  end

  # 设置本地化
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # 判断token是否过期
  def access_token_expired?
    unless @current_user.blank?
      unless @current_user.expiration_time.blank?
        @current_user.expiration_time.to_i <= Time.now.to_i
      end
    else
      fail NotAuthenticatedError
    end
  end

  # 当前用户
  def current_user
    @current_user ||= User.where(access_token: http_access_content).first unless http_access_content.blank?
  end

  def self.code_status
    {
      ok: 200,
      created: 201,
      unauthorized: 401,
      forbidden: 403,
      not_found: 404,
      unprocessable_entity: 422,
      internal_server_error: 500,
      not_implemented: 501,
      already_registered: 1201,
      none_token: 1401,
      token_expired: 1402
    }
  end

  # 200 - 300 and 1200 - 1300
  def render_success_json(msg = '', status = :ok, data = nil, links = nil)
    render  json: {
              status: 'success',
              code: ApplicationHelper.code_status[status],
              msg: msg,
              data: data,
              links: links
            }, status: status
  end

  # 400 - 500 and 1400 - 1500
  def render_fail_json(msg = '', status = :unauthorized, data = nil, links = nil)
    render  json: {
              status: 'fail',
              code: ApplicationHelper.code_status[status],
              msg: msg,
              data: data,
              links: links
            }, status: status
  end

  # 500 - 600 and 1500 - 1600
  def render_error_json(msg = '', status = :internal_server_error, data = nil, links = nil)
    render  json: {
              status: 'error',
              code: ApplicationHelper.code_status[status],
              msg: msg,
              data: data,
              links: links
            }, status: status
  end
end