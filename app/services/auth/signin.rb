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
      raise CustomException.new('password or email incorrect', 403) unless @user&.authenticate(@params[:password])
      encode_token(@user)
    end
  end
end
