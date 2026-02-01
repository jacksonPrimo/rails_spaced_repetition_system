class ApplicationController < ActionController::Base
  # proteção contra CSRF para formulários HTML
  protect_from_forgery with: :exception
  rescue_from ::CustomException, with: :custom_exception_handler

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
end
