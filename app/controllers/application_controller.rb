class ApplicationController < ActionController::API
  before_action :require_login

  def encode_token(payload)
    puts "no encode aqui"
    puts Rails.application.credentials.secret_key_base
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    puts 'auth Header supposed to be here show us secret'
    puts Rails.application.credentials.secret_key_base
    puts auth_header
    return unless auth_header

    token = auth_header.split(' ')[1]
    puts 'token here'
    puts token
    begin
      JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      []
    end
  end

  def session_user
    puts "log loking session User"
    decoded_hash = decoded_token
    puts "decoded hash check it here"
    puts decoded_hash.empty?
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
