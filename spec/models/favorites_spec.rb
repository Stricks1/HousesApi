require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe '#Images' do
    let(:user) { create(:user) }
    let(:place) { create(:place, user_id: user.id) }
    let(:favorite) { build(:favorite, user_id: user.id, place_id: place.id) }
    it 'should be associated with user and place' do
      favorite.save
      expect(favorite.user).to eq(user)
      expect(favorite.place).to eq(place)
    end
  end
end
