# frozen_string_literal: true

class AddForeignKeyConstraints < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :currency_listings, :currencies
    add_foreign_key :currency_listings, :listings
    add_foreign_key :listings, :users, column: :submitter_id
  end
end
