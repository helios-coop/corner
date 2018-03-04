class CreateCurrencyListings < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_listings do |t|
      t.integer :currency_id
      t.integer :listing_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :currency_listings, :currency_id
    add_index :currency_listings, :listing_id
    add_index :currency_listings, :deleted_at
  end
end
