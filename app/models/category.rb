class Category < ApplicationRecord
    has_many :category_doctors
    has_many :doctors, through: :category_doctors
end
