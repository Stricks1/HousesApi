module V1
  class RentDatesController < ApplicationController
    before_action :rent_event, only: %i[show update destroy]

    def index
      rents_user = RentDate.includes(:place).where(user_id: @user.id).order(:start_date)
      render json: RentDateSerializer.new(rents_user).serialized_json
    end

    def create
      rent_event = RentDate.new(rent_params)

      start_date_arr = rent_params['start_date'].split('-')
      end_date_arr = rent_params['end_date'].split('-')
      start_date = Date.new(start_date_arr[0].to_i, start_date_arr[1].to_i, start_date_arr[2].to_i)
      end_date = Date.new(end_date_arr[0].to_i, end_date_arr[1].to_i, end_date_arr[2].to_i)
      total_days = (end_date - start_date).to_i
      rent_event.user = @user
      rent_event.rent_price = rent_event.price_rent(total_days)
      if RentDate.between(rent_event.place_id, start_date, end_date)
        if rent_event.save
          render json: RentDateSerializer.new(rent_event).serialized_json
        else
          render json: rent_event.errors.messages.as_json, status: :not_acceptable
        end
      else
        render json: { status: 'Rent date already exists' }
      end
    end

    def show
      render json: RentDateSerializer.new(@rent_event).serialized_json
    end

    def destroy
      if @rent_event.destroy
        render json: { status: 'Rent date removed' }
      else
        render json: @rent_event.errors.messages.as_json, status: :not_acceptable
      end
    end

    private

    def rent_params
      params.require(:rent_date).permit(:place_id, :start_date, :end_date)
    end

    def rent_event
      @rent_event ||= RentDate.includes(:place).find(params[:id])
    end
  end
end
