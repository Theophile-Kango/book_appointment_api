FactoryBot.define do
    factory :category do
      type { Faker::Lorem.word }
    end
end