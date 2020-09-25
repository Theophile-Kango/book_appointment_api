# frozen_string_literal: true

class AddColumnImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string
  end
end
