module V1
  class RentDatesController < ApplicationController
    before_action :rentEvent, only: %i[show update destroy]


    def index
      rentsUser = RentDate.includes(:place).where(user_id: @user.id)
      render json: RentDateSerializer.new(rentsUser).serialized_json
    end

    def create
      rentEvent = RentDate.new(rent_params)
      unity_price = Place.find(rent_params['place_id']).daily_price

      start_date_arr = rent_params['start_date'].split('-')
      end_date_arr = rent_params['end_date'].split('-')
      start_date = Date.new(start_date_arr[0].to_i,start_date_arr[1].to_i,start_date_arr[2].to_i)
      end_date = Date.new(end_date_arr[0].to_i,end_date_arr[1].to_i,end_date_arr[2].to_i)
      total_price = unity_price * (end_date - start_date).to_i
      rentEvent.user = @user
      rentEvent.rent_price = total_price

      if rentEvent.save
        render json: RentDateSerializer.new(rentEvent).serialized_json
      else
        render json: rentEvent.errors.messages.as_json, status: :not_acceptable
      end
    end

    def show
      render json: RentDateSerializer.new(@rentEvent).serialized_json
    end

    def destroy
      if @rentEvent.destroy
        render json: { status: 'Rent date removed' }
      else
        render json: @rentEvent.errors.messages.as_json, status: :not_acceptable
      end
    end

    private

    def rent_params
      params.require(:rent_date).permit(:place_id, :start_date, :end_date)
    end

    def rentEvent
      @rentEvent ||= RentDate.includes(:place).find(params[:id])
    end
  end
end
