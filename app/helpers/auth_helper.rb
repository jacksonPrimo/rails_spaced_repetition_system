require 'jwt'

module AuthHelper
  def encode_token(user)
    exp = 3.days.from_now
    token = JWT.encode({ user_id: user.id, exp: exp.to_i }, ENV.fetch('JWT_SECRET'), 'HS256')

    { token: token, exp: exp }
  end

  def decode_token(token)
    JWT.decode(token, ENV.fetch('JWT_SECRET'))[0]
  end
end
