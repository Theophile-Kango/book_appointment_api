# frozen_string_literal: true

class RemoveColumnCategoryFromDoctors < ActiveRecord::Migration[6.0]
  def change
    remove_reference :doctors, :category, null: false, foreign_key: true
  end
end
