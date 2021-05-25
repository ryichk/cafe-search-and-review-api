class ApplicationController < ActionController::API
  before_action :detect_locate

  # 例外処理
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def after_sign_out_path_for(resource)
      '/users/sign_in'  # サインアウト後のリダイレクト先URL
  end

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end

    private
      def  detect_locate
        I18n.locale = request.headers['Accept-Language'].scan(/\A[a-z]{2}/).first
      end
end
