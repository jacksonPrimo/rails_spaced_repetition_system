class AuthController < ApplicationController
  def signin; end

  def signup; end

  def do_signin
    result = ::Auth::Signin.new(params).call
    render_result result, success_path: :signin
  end

  def do_signup
    result = ::Auth::Signup.new(
      params.permit(:name, :email, :password).to_h
    ).call
    render_result result, success_path: :signup
  end
end
