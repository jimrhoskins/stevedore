class V1::ApiController < ApplicationController
  def require_user
    logger.warn "Auth #{request.headers[:authorization]}"
    unless current_user
      #binding.pry
      render status: 401, text: "Not Authorized"
    end
  end

  def current_user
    @current_user ||= super || current_user_from_basic || current_user_from_token
  end

  def current_user_from_basic
    header = request.headers[:authorization]
    if header and header.match(/Basic /i)
      b64 = header.strip.split(/\s+/)[1]
      username, password = Base64.decode64(b64).split(":")
      user = User.find_by username: username

      if user and user.valid_password? password
        send_token(user)
        return user
      end
    end
    nil
  end

  def current_user_from_token
    header = request.headers[:authorization]
    if header and header.match(/Token /i)
      sig = header.match(/signature=([a-f0-9]+)/i)[1]
      token = Token.find_by signature: sig
      if token
        sign_in :user, token.user
        token.destroy
        return token.user
      end
    end
    nil
  end

  def send_token(user)
    token = user.tokens.create!(access: 'read')
    response.headers['X-Docker-Token'] = token.to_s
    #response.headers['WWW-Authenticate'] = "Token #{token.to_s}"
  end

end
