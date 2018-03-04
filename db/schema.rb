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

ActiveRecord::Schema.define(version: 20180304203102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currency_listings", force: :cascade do |t|
    t.integer "currency_id"
    t.integer "listing_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_currency_listings_on_currency_id"
    t.index ["deleted_at"], name: "index_currency_listings_on_deleted_at"
    t.index ["listing_id"], name: "index_currency_listings_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.string "phone"
    t.string "url"
    t.integer "submitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submitter_id"], name: "index_listings_on_submitter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.string "role"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
