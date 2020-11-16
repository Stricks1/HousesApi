require 'rails_helper'
# rubocop:disable Layout/LineLength
RSpec.describe 'Favorites', type: :request do
  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }
  let(:place2) { create(:place, user_id: user.id) }

  describe '#Favorites' do
    it 'setting a favorite place for logged user' do
      user
      place
      place2
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/favorites', params: {
        favorite: {
          place_id: place.id
        }
      }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      
      resp_body = JSON.parse(response.body)
      expect(resp_body['data']['attributes']['place_id']).to eq(place.id)
      expect(resp_body['data']['attributes']['user_id']).to eq(user.id)
    end

    it 'show the favorite places list for the user' do
      user
      place
      place2
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)      
      get '/v1/favorites', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      resp_body = JSON.parse(response.body)
      expect(resp_body['data']).to match_array([])
      expect(resp_body['data']).to match_array([])
      post '/v1/favorites', params: {
        favorite: {
          place_id: place.id
        }
      }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      
      get '/v1/favorites', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      resp_body = JSON.parse(response.body)
      expect(resp_body['data'][0]['attributes']['place_id']).to eq(place.id)
      expect(resp_body['data'][0]['attributes']['user_id']).to eq(user.id)
   end

    it 'deletes a favorite place' do
      user
      place
      place2
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)      
      post '/v1/favorites', params: {
        favorite: {
          place_id: place.id
        }
      }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      delete "/v1/favorites/#{place.id}", headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response.body).to include('favorite removed')
    end
  end
  # rubocop:enable Layout/LineLength
end