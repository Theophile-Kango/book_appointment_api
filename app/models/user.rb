class User < ApplicationRecord
  has_one_attached :image
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
  # encrypt password
  has_secure_password

  # Validations
  validates_presence_of :name, :email, :password_digest, :image
  validates_uniqueness_of :email
end
