require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#Registration' do
    let(:user) { create(:user) }
    it 'dont accept user without username' do
      user.username = nil
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")

      user.username = 'userTest'
      user.valid?
      expect(user.errors[:username]).to_not include("can't be blank")
    end

    it 'dont accept user without email' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'test@mail.com'
      user.valid?
      expect(user.errors[:email]).to_not include("can't be blank")
    end

    it 'dont accept same email or username' do
      user
      user2 = build(:user)
      expect(user2).to_not be_valid
    end

    it 'user password need to match confirmation' do
      user.password = '123456789'
      user.password_confirmation = 'testepass'
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")

      user.password = '123456789'
      user.password_confirmation = '123456789'
      user.valid?
      expect(user.errors[:password_confirmation]).to_not include("doesn't match Password")
    end
  end
end
