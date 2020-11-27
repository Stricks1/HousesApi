require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '#Users' do
    it 'creates a user' do
      post '/v1/users', params: { user: { username:
        'test', email:
        'test@mail.com',
                                          password: '123456789',
                                          password_confirmation: '123456789' } }
      expect(response.body).to include('test')
    end

    it 'user with same email or username cant be created' do
      post '/v1/users', params: { user: {
        username: 'test',
        email: 'test@mail.com',
        password: '123456789',
        password_confirmation: '123456789'
      } }
      post '/v1/users', params: { user: {
        username: 'test',
        email: 'test2@mail.com',
        password: '123456789',
        password_confirmation: '123456789'
      } }
      expect(response.body).to include('"username":["has already been taken"]')
      post '/v1/users', params: { user: {
        username: 'test2',
        email: 'test@mail.com',
        password: '123456789',
        password_confirmation: '123456789'
      } }
      expect(response.body).to include('"email":["has already been taken"]')
    end
  end
end
