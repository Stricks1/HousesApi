FactoryBot.define do
  factory :place do
    location_type { Faker::Number.number(digits: 1) }
    address { Faker::ChuckNorris.fact }
    city { Faker::Name.name }
    country { Faker::Name.name }
    daily_price { Faker::Number.decimal(l_digits: 2) }
  end
end