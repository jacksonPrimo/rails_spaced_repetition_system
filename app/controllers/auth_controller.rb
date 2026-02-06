class AuthController < ApplicationController
  def signin; end

  def signup; end

  def do_signin
    result = ::Auth::Signin.new(params).call
    session[:token] = result[:token]
    render_result result, success_path: '/packs'
  end

  def do_signup
    result = ::Auth::Signup.new(params.permit(:name, :email, :password).to_h).call
    session[:token] = result[:token]
    render_result result, success_path: '/packs'
  end
end
