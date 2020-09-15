
FactoryBot.define do
    factory :appointment do
      date { Faker::Time.forward(days: 5,  period: :evening, format: :long) }
      category_id nil 
      doctor_id nil 
      user_id nil 
    end
end