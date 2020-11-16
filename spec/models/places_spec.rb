require 'rails_helper'

RSpec.describe Place, type: :model do
  describe '#Places' do
    let(:user) { create(:user) }
    let(:place) { create(:place, user_id: user.id) }
    it 'dont accept place with empty location type' do
      place.location_type = nil
      place.valid?
      expect(place.errors[:location_type]).to include("can't be blank")

      place.location_type = 1
      place.valid?
      expect(place.errors[:location_type]).to_not include("can't be blank")
    end

    it 'dont accept place with empty address' do
      place.address = nil
      place.valid?
      expect(place.errors[:address]).to include("can't be blank")

      place.address = 'something'
      place.valid?
      expect(place.errors[:address]).to_not include("can't be blank")
    end

    it 'dont accept place with empty city' do
      place.city = nil
      place.valid?
      expect(place.errors[:city]).to include("can't be blank")

      place.city = 'City'
      place.valid?
      expect(place.errors[:city]).to_not include("can't be blank")
    end

    it 'dont accept place with empty country' do
      place.country = nil
      place.valid?
      expect(place.errors[:country]).to include("can't be blank")

      place.country = 'country'
      place.valid?
      expect(place.errors[:country]).to_not include("can't be blank")
    end

    it 'dont accept place with empty daily price' do
      place.daily_price = nil
      place.valid?
      expect(place.errors[:daily_price]).to include("can't be blank")

      place.daily_price = 10.20
      place.valid?
      expect(place.errors[:daily_price]).to_not include("can't be blank")
    end
  end
end