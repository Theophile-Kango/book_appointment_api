class CategoryDoctor < ApplicationRecord
  belongs_to :categorie
  belongs_to :doctor
end
