# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180317011800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "symbol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies_listings", force: :cascade do |t|
    t.integer "currency_id", null: false
    t.integer "listing_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id", "listing_id"], name: "index_currencies_listings_on_currency_id_and_listing_id", unique: true
    t.index ["currency_id"], name: "index_currencies_listings_on_currency_id"
    t.index ["deleted_at"], name: "index_currencies_listings_on_deleted_at"
    t.index ["listing_id"], name: "index_currencies_listings_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.string "phone"
    t.string "url"
    t.integer "submitter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "long"
    t.string "google_places_id"
    t.index ["google_places_id"], name: "index_listings_on_google_places_id", unique: true
    t.index ["submitter_id"], name: "index_listings_on_submitter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "role"
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "currencies_listings", "currencies"
  add_foreign_key "currencies_listings", "listings"
  add_foreign_key "listings", "users", column: "submitter_id"
end
