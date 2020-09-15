FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      image ''
      email 'foo@bar.com'
      password 'foobar'
    end
end