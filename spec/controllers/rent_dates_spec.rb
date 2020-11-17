require 'rails_helper'
RSpec.describe 'Rent Date', type: :request do
  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }
  let(:place2) { create(:place, user_id: user.id) }
  let(:rent_date) { create(:rent_date, user_id: user.id, place_id: place.id) }
  let(:rent_date2) { create(:rent_date, user_id: user.id, place_id: place2.id) }

  describe '#RentDates' do
    it 'creates a rent_date belonging to logged user' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/rent_dates', params: { rent_date: {
        place_id: place.id,
        start_date: '2020-11-20',
        end_date: '2020-11-22',
      } }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      resp_body = JSON.parse(response.body)
      rent_created = RentDate.find(resp_body['data']['id'])
      expect(rent_created.user_id).to eq(user.id)
    end

    it 'creates a rent_date computing price with place daily' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      post '/v1/rent_dates', params: { rent_date: {
        place_id: place.id,
        start_date: '2020-11-20',
        end_date: '2020-11-22',
      } }, headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      resp_body = JSON.parse(response.body)
      
      expect(resp_body['data']['attributes']['rent_price']).to eq((place.daily_price * 2).to_s)
    end

    it 'show the rent dates list for user' do
      user
      place
      place2
      rent_date
      rent_date2
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get '/v1/rent_dates', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      resp_body = JSON.parse(response.body)
      expect(resp_body['data'][0]['attributes']['place_id']).to eq(place.id)
      expect(resp_body['data'][1]['attributes']['place_id']).to eq(place2.id)
    end

    it 'show the rent date with id' do
      user
      place
      rent_date
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get "/v1/rent_dates/#{rent_date.id}", headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      resp_body = JSON.parse(response.body)
      expect(resp_body['data']['id'].to_i).to eq(rent_date.id)
    end

    it 'deletes a rent date record' do
      user
      place
      rent_date
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      delete "/v1/rent_dates/#{rent_date.id}", headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }

      expect(response.body).to include('Rent date removed')
    end
  end
end
