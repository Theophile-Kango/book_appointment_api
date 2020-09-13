class Appoitment < ApplicationRecord
  belongs_to :category
  belongs_to :doctor
  belongs_to :user
end
