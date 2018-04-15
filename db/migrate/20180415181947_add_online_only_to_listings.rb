# frozen_string_literal: true

class AddOnlineOnlyToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :online_only, :boolean
  end
end
