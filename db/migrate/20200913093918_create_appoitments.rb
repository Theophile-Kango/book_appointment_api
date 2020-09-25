# frozen_string_literal: true

class CreateAppoitments < ActiveRecord::Migration[6.0]
  def change
    create_table :appoitments do |t|
      t.date :date
      t.references :category, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
