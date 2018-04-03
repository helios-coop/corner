# frozen_string_literal: true

class AddNotNulls < ActiveRecord::Migration[5.1]
  def change
    change_column_null :listings, :submitter_id, false
    change_column_null :users, :role, false
  end
end
