module Auth
  class Signin < Base
    include AuthHelper

    def call
      find_user
      authenticate
    end

    def find_user
      @user = ::User.find_by_email(@params[:email])
    end

    def authenticate
      raise CustomException.new(
        message: 'password or email incorrect',
        code: 403,
        redirect_path: :signin
      ) unless @user&.authenticate(@params[:password])

      encode_token(@user)
    end
  end
end
