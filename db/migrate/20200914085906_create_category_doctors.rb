class CreateCategoryDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :category_doctors do |t|
      t.references :categorie, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
