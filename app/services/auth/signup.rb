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
      raise CustomException.new('email already in use', 400) if user
    end

    def create_user
      user = User.new(sanitize_params)
      return user if user.save

      raise ::CustomException.new("cannot register user: #{user.errors.to_a}", 400)
    end

    def sanitize_params
      @params.permit(:name, :password, :email)
    end
  end
end
