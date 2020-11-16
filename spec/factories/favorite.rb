FactoryBot.define do
  factory :favorite do
    association :user
    association :place
  end
end