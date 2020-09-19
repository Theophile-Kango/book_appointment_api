# frozen_string_literal: true

FactoryBot.define do
  factory :admin, class: 'User' do
    name { Faker::Name.name }
    email { 'a@gmail.com' }
    password { 'foobar' }
    admin { true }
    password_confirmation { 'foobar' }
    image { Rack::Test::UploadedFile.new('./spec/support/corona.png', 'image/png') }
  end
end
