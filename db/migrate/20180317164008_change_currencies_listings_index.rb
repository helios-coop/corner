# frozen_string_literal: true

class ChangeCurrenciesListingsIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :currencies_listings,
                 %i[currency_id listing_id]

    add_index :currencies_listings,
              %i[currency_id listing_id],
              where: 'deleted_at IS NULL',
              unique: true
  end
end
