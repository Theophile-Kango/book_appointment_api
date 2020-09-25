# frozen_string_literal: true

class ChangeName < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :type, :name
  end
end
