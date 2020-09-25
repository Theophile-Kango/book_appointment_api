# frozen_string_literal: true

class AddDateToAppoitments < ActiveRecord::Migration[6.0]
  def change
    add_column :appoitments, :date, :datetime
  end
end
