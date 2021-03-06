module V1
  class PlacesController < ApplicationController
    before_action :place, only: %i[show update destroy occupied]
    before_action :set_image_list, only: %i[index update show]

    def index
      places = Place.order(:created_at).includes(:images).all
      render json: PlaceSerializer.new(places, @image_list).serialized_json
    end

    def create
      place = Place.new(place_params)
      place.user = @user

      if place.save
        render json: PlaceSerializer.new(place).serialized_json
      else
        render json: place.errors.messages.as_json, status: :not_acceptable
      end
    end

    def show
      render json: PlaceSerializer.new(@place, @image_list).serialized_json
    end

    def occupied
      start_date_arr = params['place']['date_ini'].split('-')
      end_date_arr = params['place']['date_end'].split('-')
      start_date = Date.new(start_date_arr[0].to_i, start_date_arr[1].to_i, start_date_arr[2].to_i)
      end_date = Date.new(end_date_arr[0].to_i, end_date_arr[1].to_i, end_date_arr[2].to_i)
      list_rented_date = RentDate.between(params[:id], start_date, end_date).order(:start_date)
      list_occupied = []
      list_occupied_end = []
      list_rented_date.each do |rent_event|
        loop_date = rent_event.start_date < start_date ? start_date : rent_event.start_date
        loop_end_date = rent_event.end_date > end_date ? end_date : rent_event.end_date
        while loop_date < loop_end_date
          list_occupied << loop_date
          loop_date += 1.days
          list_occupied_end << loop_date
        end
      end
      render json: { occupied: [list_occupied], occupied_end: [list_occupied_end] }
    end

    def update
      if @place.user != @user
        render json: { status: 'place dont belong to user' }
      elsif @place.update(
        location_type: params['place']['location_type'],
        address: params['place']['address'],
        city: params['place']['city'],
        country: params['place']['country'],
        daily_price: params['place']['daily_price']
      )
        render json: PlaceSerializer.new(@place, @image_list).serialized_json
      else
        render json: @place.errors.messages.as_json, status: :not_acceptable
      end
    end

    def destroy
      if @place.user != @user
        render json: { status: 'place dont belong to user' }
      elsif @place.destroy
        render json: { status: 'place removed' }
      else
        render json: @place.errors.messages.as_json, status: :not_acceptable
      end
    end

    private

    def place_params
      params.require(:place).permit(:location_type, :address, :city, :country, :daily_price, :date_ini, :date_end)
    end

    def set_image_list
      @image_list = { include: [:images] }
    end

    def place
      @place ||= Place.includes(:images).find(params[:id])
    end
  end
end
