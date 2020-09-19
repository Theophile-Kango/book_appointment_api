# frozen_string_literal: true

class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
