module V1
  class ImagesController < ApplicationController
    def create
      image = Image.new(image_params)
      if image.save
        render json: ImageSerializer.new(image).serialized_json
      else
        render json: image.errors.messages.as_json, status: :not_acceptable
      end
    end

    def destroy
      image = Image.find(params[:id])
      if image.destroy
        render json: { status: 'image removed' }
      else
        render json: image.errors.messages.as_json, status: :not_acceptable
      end
    end

    private

    def image_params
      params.require(:image).permit(:image_url, :place_id)
    end
  end
end
