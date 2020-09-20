FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'test@gail.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    image { Rack::Test::UploadedFile.new('./spec/support/corona.png', 'image/png') }
  end
end
