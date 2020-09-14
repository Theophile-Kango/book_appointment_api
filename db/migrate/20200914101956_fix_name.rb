class FixName < ActiveRecord::Migration[6.0]
  def change
    rename_column :category_doctors, :categorie_id, :category_id
  end
end
