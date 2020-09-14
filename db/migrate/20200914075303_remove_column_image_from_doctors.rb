class RemoveColumnImageFromDoctors < ActiveRecord::Migration[6.0]
  def change
    remove_column :doctors, :image, :string
  end
end
