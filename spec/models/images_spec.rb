require 'rails_helper'

RSpec.describe Image, type: :model do
  describe '#Images' do
    let(:image) { build(:image) }
    it 'dont accept image without URL image' do
      image.image_url = nil
      image.valid?
      expect(image.errors[:image_url]).to include("can't be blank")

      image.image_url = 'something'
      image.valid?
      expect(image.errors[:image_url]).to_not include("can't be blank")
    end
  end
end
