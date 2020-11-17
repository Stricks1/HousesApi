class ApplicationController < ActionController::API
  before_action :require_login

  def encode_token(payload)
    puts "no encode aqui"
    puts "6b062965b15e39e2c0aedfff4665f04336b0b45412821b9d3405d6dd581545c967df679787973a5f365642369c5c86050a69d7f1249c3d3477ae72518f01c464"
    JWT.encode(payload, "6b062965b15e39e2c0aedfff4665f04336b0b45412821b9d3405d6dd581545c967df679787973a5f365642369c5c86050a69d7f1249c3d3477ae72518f01c464")
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    puts 'auth Header supposed to be here show us secret'
    puts "6b062965b15e39e2c0aedfff4665f04336b0b45412821b9d3405d6dd581545c967df679787973a5f365642369c5c86050a69d7f1249c3d3477ae72518f01c464"
    puts auth_header
    return unless auth_header

    token = auth_header.split(' ')[1]
    puts 'token here'
    puts token
    begin
      JWT.decode(token, "6b062965b15e39e2c0aedfff4665f04336b0b45412821b9d3405d6dd581545c967df679787973a5f365642369c5c86050a69d7f1249c3d3477ae72518f01c464", true, algorithm: 'HS256')
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
