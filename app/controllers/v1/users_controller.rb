module V1
  class UsersController < ApplicationController
    def create
      @user = User.new(user_params)

      if @user.save
        payload = {user_id: user.id}
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