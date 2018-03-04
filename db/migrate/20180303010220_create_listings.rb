class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :phone
      t.string :url
      t.integer :submitter_id

      t.timestamps
    end

    add_index :listings, :submitter_id
  end
end
