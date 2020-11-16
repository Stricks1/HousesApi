require 'rails_helper'
RSpec.describe 'Places', type: :request do
  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }
  let(:place2) { create(:place, user_id: user.id) }

  describe '#Places' do
    it 'creates a place belonging to logged user' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/places', params: { place: {
        location_type: 1,
        address: 'address test',
        city: 'Blumenau',
        country: 'Brazil',
        daily_price: 22.22
      } }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      resp_body = JSON.parse(response.body)
      place_created = Place.find(resp_body['data']['id'])
      expect(place_created.user_id).to eq(user.id)
    end

    it 'show the places list' do
      user
      place
      place2
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get '/v1/places', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      resp_body = JSON.parse(response.body)
      expect(resp_body['data'][0]['attributes']['address']).to include(place.address)
      expect(resp_body['data'][1]['attributes']['city']).to include(place2.city)
    end

    it 'show the places with id' do
      user
      place
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get "/v1/places/#{place.id}", headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      resp_body = JSON.parse(response.body)
      expect(resp_body['data']['attributes']['address']).to include(place.address)
    end

    it 'update the place' do
      user
      place
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      put "/v1/places/#{place.id}", params: { place: {
        location_type: 1,
        address: 'address changed',
        city: 'Blumenau',
        country: 'Brazil',
        daily_price: 22.22
      } }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      resp_body = JSON.parse(response.body)
      expect(resp_body['data']['attributes']['address']).to include('address changed')
    end

    it 'deletes a place' do
      user
      place
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      delete "/v1/places/#{place.id}", headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      expect(response.body).to include('place removed')
    end
  end
end
