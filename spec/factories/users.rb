FactoryBot.define do
  factory :user do
    username { 'test' }
    email { 'test@mail.com' }
    password { '123456789' }
    password_confirmation { '123456789' }
  end
end
