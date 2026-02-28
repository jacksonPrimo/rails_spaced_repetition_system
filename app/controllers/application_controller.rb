class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # proteção contra CSRF para formulários HTML
  protect_from_forgery with: :exception
  rescue_from ::CustomException, with: :custom_exception_handler

  def custom_exception_handler(exception)
    respond_to do |format|
      format.json { render json: { message: exception.message, details: exception.details }, status: exception.code || :unprocessable_entity }
      format.html do
        flash[:alert] = exception.message
        redirect_to exception.redirect_path
      end
    end
  end

  def render_result(result, success_path: root_path)
    respond_to do |format|
      format.json { render json: result }
      format.html { redirect_to success_path, notice: 'Operação realizada com sucesso!' }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
