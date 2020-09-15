class User < ApplicationRecordh
    has_one_attached :image
    has_many :appointments, dependent: :destroy
    has_many :doctors, through: :appointments
end
