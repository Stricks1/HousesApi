FactoryBot.define do
  factory :rent_date do
    start_date { Faker::Date.between(from: '2020-09-23', to: '2014-09-25') }
    end_date { Faker::Date.between(from: '2020-10-12', to: '2020-10-20') }
  end
end
