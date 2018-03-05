class AddConstraints < ActiveRecord::Migration[5.1]
  def change
    add_index :currency_listings, %i[currency_id listing_id], unique: true
    change_column_null :currencies, :name, false
    change_column_null :currencies, :symbol, false
    change_column_null :currency_listings, :currency_id, false
    change_column_null :currency_listings, :listing_id, false
    change_column_null :listings, :name, false
    change_column_null :listings, :submitter_id, false
    change_column_null :users, :display_name, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
  end
end
