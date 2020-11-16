FactoryBot.define do
  factory :image do
    image_url { 'https://www.freeimages.com/photo' }
    association :place
  end
end