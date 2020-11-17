class ApplicationController < ActionController::API
  before_action :require_login

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_login_api)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.credentials.secret_login_api, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      []
    end
  end

  def session_user
    decoded_hash = decoded_token
    return nil if decoded_hash.empty?

    authentication_token = decoded_hash[0]['authentication_token']
    @user = User.find_by(authentication_token: authentication_token)
  end

  def logged_in?
    session_user
  end

  def require_login
    render json: { message: 'Please Login' }, status: :unauthorized unless logged_in?
  end
end
