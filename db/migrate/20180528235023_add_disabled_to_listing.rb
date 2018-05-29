# frozen_string_literal: true

class AddDisabledToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :disabled, :boolean
  end
end
