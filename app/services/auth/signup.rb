module Auth
  class Signup < Base
    include AuthHelper

    def call
      already_has_user_with_this_email?
      user = create_user
      encode_token(user)
    end

    def already_has_user_with_this_email?
      user = ::User.find_by(email: @params[:email])
      raise CustomException.new(
        message: 'email already in use', code: 400, redirect_path: :signup
      ) if user
    end

    def create_user
      user = User.new(sanitize_params)
      return user if user.save

      raise ::CustomException.new(
        message: "cannot register user: #{user.errors.to_a}", code: 400, redirect_path: :signup
      )
    end

    def sanitize_params
      @params.slice(:name, :password, :email)
    end
  end
end
