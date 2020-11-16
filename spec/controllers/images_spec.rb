require 'rails_helper'
# rubocop:disable Layout/LineLength
RSpec.describe 'Images', type: :request do
  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }

  describe '#Images' do
    it 'creates an image' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/images', params: { image: { 
          image_url: "https://hotelgloria.com.br/wp-content/uploads/2019/07/hotel-gloria-blumenau-sc.jpg",
          place_id: place.id
        } 
      }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      expect(response).to be_successful
    end

    it 'saves the new image' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/images', params: { image: { 
          image_url: "https://hotelgloria.com.br/wp-content/uploads/2019/07/hotel-gloria-blumenau-sc.jpg",
          place_id: place.id
        } 
      }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response.body).to include('https://hotelgloria.com.br/wp-content/uploads/2019/07/hotel-gloria-blumenau-sc.jpg')
    end

    it 'deletes an image' do      
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/images', params: { image: { 
          image_url: "https://hotelgloria.com.br/wp-content/uploads/2019/07/hotel-gloria-blumenau-sc.jpg",
          place_id: place.id
        } 
      }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      delete "/v1/images/#{Image.last.id}", headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response).to be_successful
    end
  end
  # rubocop:enable Layout/LineLength
end