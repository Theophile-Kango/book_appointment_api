# frozen_string_literal: true

class RemoveColumnNameFromDoctors < ActiveRecord::Migration[6.0]
  def change
    remove_column :doctors, :name, :string
  end
end
