module V1
  class FavoritesController < ApplicationController
    def index
      favorites = Favorite.where(user_id: @user.id)
      render json: FavoriteSerializer.new(favorites).serialized_json
    end

    def create
      favorite = Favorite.new(favorite_params)
      favorite.user = @user
      if favorite.save
        render json: FavoriteSerializer.new(favorite).serialized_json
      else
        render json: favorite.errors.messages.as_json, status: :not_acceptable
      end
    end

    def destroy
      favorite = Favorite.find_by(place_id: params[:id], user_id: @user.id)
      if favorite.destroy
        render json: { status: 'favorite removed' }
      else
        render json: favorite.errors.messages.as_json, status: :not_acceptable
      end
    end

    private

    def favorite_params
      params.require(:favorite).permit(:place_id)
    end
  end
end
