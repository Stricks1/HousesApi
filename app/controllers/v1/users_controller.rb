module V1
  class UsersController < ApplicationController
    skip_before_action :require_login

    def create
      @user = User.new(user_params)

      if @user.save
        expiry = (Time.now + 1.week).to_i
        payload = {
          authentication_token: @user.authentication_token,
          exp: expiry
        }
        token = encode_token(payload)
        render :create, status: :created, locals: { token: token }
      else
        render json: @user.errors.messages.as_json(), status: :not_acceptable
      end
    end
    
    private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end 
end