
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe '#Auth' do
    let(:user) { create(:user) }
    it 'creates a login generating token' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      expect(response.body).to include('test')
    end

    it 'check logged user when auto login and token still valid' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get '/v1/auto_login', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response.body).to include('test')
    end

    it 'check if user have authorization using a valid token' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get '/v1/user_is_authed', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response.body).to include('You are authorized')
    end

    it 'logout session test if token become invalid' do
      user
      post '/v1/login', params: { username: 'test', password: '123456789' }
      parsed_body = JSON.parse(response.body)
      get '/v1/logout', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response.body).to include('logged_out')
      get '/v1/user_is_authed', headers: { 'Authorization' => 'Bearer ' + parsed_body['data']['token'] }
      expect(response.body).to_not include('You are authorized')
    end
  end
end