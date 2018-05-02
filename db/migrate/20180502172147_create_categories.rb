# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :categories_listings do |t|
      t.integer :category_id
      t.integer :listing_id

      t.timestamps
    end

    add_index :categories_listings, :category_id
    add_index :categories_listings, :listing_id
  end
end
