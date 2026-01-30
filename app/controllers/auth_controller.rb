class AuthController < ApplicationController
  def signin
    result = ::UseCases::Auth::Signin.new(params).call
    render_result result
  end

  def signup
    result = ::UseCases::Auth::Signup.new(params).call
    render_result result
  end
end
