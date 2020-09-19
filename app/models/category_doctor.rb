# frozen_string_literal: true

class CategoryDoctor < ApplicationRecord
  belongs_to :category
  belongs_to :doctor
end
