class RenameCurrenyListings < ActiveRecord::Migration[5.1]
  def change
    rename_table :currency_listings, :currencies_listings
  end
end
