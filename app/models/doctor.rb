class Doctor < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :category_doctors
  has_many :categories, through: :category_doctors
end
