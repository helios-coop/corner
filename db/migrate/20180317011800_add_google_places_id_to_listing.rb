# frozen_string_literal: true

class AddGooglePlacesIdToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :google_places_id, :string
    add_index :listings, :google_places_id, unique: true
  end
end
