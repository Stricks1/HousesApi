module V1
  class PlacesController < ApplicationController
    before_action :place, only: %i[show update destroy]

    def index
    end

    def create
      place = Place.new(place_params)
      place.user = @user
      
      if place.save
        render json: PlaceSerializer.new(place).serialized_json
      else
        render json: place.errors.messages.as_json(), status: :not_acceptable
      end
    end

    def show
      render json: PlaceSerializer.new(@place).serialized_json
    end

    def update
    end

    def destroy
    end

    private

    def place_params
      params.require(:place).permit(:location_type, :address, :city, :country, :daily_price)
    end

    def place
      @place ||= Place.find(params[:id])
    end
  end
end