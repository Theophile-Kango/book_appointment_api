class AddColumnIsDoctorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :isDoctor, :boolean, default: false
  end
end
