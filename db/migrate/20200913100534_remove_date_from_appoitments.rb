class RemoveDateFromAppoitments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appoitments, :date, :datetime
  end
end
