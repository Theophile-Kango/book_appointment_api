# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :category
  belongs_to :doctor
  belongs_to :user
  validates_presence_of :date
end
