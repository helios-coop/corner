# frozen_string_literal: true

class AddUniqueIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
    add_index :users, :display_name, unique: true
    add_index :currencies, :name, unique: true
    add_index :currencies, :symbol, unique: true
  end
end
