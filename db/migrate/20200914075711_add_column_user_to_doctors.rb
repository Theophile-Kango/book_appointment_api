class AddColumnUserToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_reference :doctors, :user, null: false, foreign_key: true
  end
end
