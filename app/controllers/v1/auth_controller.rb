module V1
  class AuthController < ApplicationController
    skip_before_action :require_login, only: %i[login auto_login]
    def login
      @user = User.find_by(username: params[:username])
      if @user&.valid_password?(params[:password])
        expiry = (Time.now + 1.week).to_i
        payload = {
          authentication_token: @user.authentication_token,
          exp: expiry
        }
        token = encode_token(payload)
        render :create, success: "Welcome back, #{@user.username}", locals: { token: token }
      else
        render json: { errors: 'Log in failed! Username or password invalid!' }
      end
    end

    def logout
      if session_user
        @user.authentication_token = nil
        @user.save
        render json: { status: 200, logged_out: true }
      else
        render json: { errors: 'No User Logged In' }
      end
    end

    def auto_login
      if session_user
        render json: { user: { id: session_user.id, username: session_user.username, email: session_user.email } }
      else
        render json: { errors: 'No User Logged In' }
      end
    end

    def user_is_authed
      render json: { message: 'You are authorized' }
    end
  end
end
