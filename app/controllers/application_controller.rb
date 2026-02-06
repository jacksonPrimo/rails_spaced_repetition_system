class ApplicationController < ActionController::Base
  include AuthHelper
  # proteção contra CSRF para formulários HTML
  protect_from_forgery with: :exception
  rescue_from ::CustomException, with: :custom_exception_handler
  helper_method :current_user, :user_signed_in?

  def custom_exception_handler(exception)
    respond_to do |format|
      format.json { render json: { message: exception.message, details: exception.details }, status: exception.code || :unprocessable_entity }
      format.html do
        flash.now[:alert] = exception.message
        render exception.redirect_path, status: exception.code || :unprocessable_entity
      end
    end
  end

  def render_result(result, success_path: root_path)
    respond_to do |format|
      format.json { render json: result }
      format.html { redirect_to success_path, notice: 'Operação realizada com sucesso!' }
    end
  end

  def authenticate_user
    token = request.headers['Authorization']&.remove('Bearer ') || session[:token]
    decoded_token = decode_token(token)

    @current_user = User.find_by(id: decoded_token['user_id'])

    render_unauthorized('Usuário não encontrado') unless @current_user
  rescue JWT::ExpiredSignature
    render_unauthorized('token expirado')
  rescue JWT::DecodeError
    render_unauthorized('token inválido')
  end

  def current_user
    @current_user
  end

  def user_signed_in?
    current_user.present?
  end

  def render_unauthorized(message)
    respond_to do |format|
      format.json { render json: { error: message }, status: :unauthorized }
      format.html { redirect_to '/auth/signin', alert: message }
    end
  end
end
