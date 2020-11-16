module V1
  class AuthController < ApplicationController
    skip_before_action :require_login, only: [:login, :auto_login]
    def login
      @user = User.find_by(email: params[:email])
      if @user&.valid_password?(params[:password])
        expiry = (Time.now + 1.week).to_i
        payload = {
            user_id: @user.id,
            exp: expiry
        }
        token = encode_token(payload)
        render :create, success: "Welcome back, #{@user.username}", locals: { token: token }
        #render json: {user: user, jwt: token, success: "Welcome back, #{user.username}"}
      else
        render json: {failure: "Log in failed! Username or password invalid!"}
      end
    end
  
    def auto_login
      if session_user
        render json: session_user
      else
        render json: {errors: "No User Logged In"}
      end
    end
  
    def user_is_authed
      render json: {message: "You are authorized"}
    end
  end
end