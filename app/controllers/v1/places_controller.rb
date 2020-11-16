module V1
  class PlacesController < ApplicationController
    before_action :place, only: %i[show update destroy]
    before_action :set_image_list, only: %i[index show]

    def index
      places = Place.includes(:images).all
      render json: PlaceSerializer.new(places, @image_list).serialized_json        
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
      render json: PlaceSerializer.new(@place, @image_list).serialized_json
    end

    def update
    end

    def destroy
      if @place.destroy
        render json: { status: 'place removed' }
      else
        render json: @place.errors.messages.as_json(), status: :not_acceptable
      end
    end

    private

    def place_params
      params.require(:place).permit(:location_type, :address, :city, :country, :daily_price)
    end

    def set_image_list
      @image_list = { include: [:images] }
    end

    def place
      @place ||= Place.includes(:images).find(params[:id])
    end
  end
end