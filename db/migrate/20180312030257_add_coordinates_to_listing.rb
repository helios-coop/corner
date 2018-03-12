# frozen_string_literal: true

class AddCoordinatesToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :lat, :float
    add_column :listings, :long, :float
  end
end
