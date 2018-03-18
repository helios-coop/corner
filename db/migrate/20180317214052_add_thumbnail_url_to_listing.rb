# frozen_string_literal: true

class AddThumbnailUrlToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :thumbnail_url, :string
  end
end
