require 'rails_helper'

RSpec.describe RentDate, type: :model do
  describe '#RentDate' do
    let(:user) { create(:user) }
    let(:place) { create(:place, user_id: user.id) }
    let(:rent_date) { create(:rent_date, user_id: user.id, place_id: place.id) }
    
    it 'should be associated with user and place' do
      rent_date.save
      expect(rent_date.user).to eq(user)
      expect(rent_date.place).to eq(place)
    end
  end
end
