class ApplicationController < ActionController::Base
  def render_result result
    if result.is_a?(Hash) && result[:error]
      render json: { error: result[:error] }, status: result[:code]
    else
      render json: result
    end
  end

  def params
    request.params
  end
end
