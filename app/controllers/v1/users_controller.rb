module V1
  class UsersController < ApplicationController
    def create
      @user = User.new(user_params)

      if @user.save
        render :create
      else
        render json: @user.errors.messages.as_json()
      end
    end
    
    private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end 
end