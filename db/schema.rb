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

ActiveRecord::Schema.define(version: 2018_05_28_235023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_listings", force: :cascade do |t|
    t.integer "category_id"
    t.integer "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_listings_on_category_id"
    t.index ["listing_id"], name: "index_categories_listings_on_listing_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "symbol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_currencies_on_name", unique: true
    t.index ["symbol"], name: "index_currencies_on_symbol", unique: true
  end

  create_table "currencies_listings", force: :cascade do |t|
    t.integer "currency_id", null: false
    t.integer "listing_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id", "listing_id"], name: "index_currencies_listings_on_currency_id_and_listing_id", unique: true, where: "(deleted_at IS NULL)"
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
    t.string "thumbnail_url"
    t.boolean "online_only"
    t.boolean "disabled"
    t.index ["google_places_id"], name: "index_listings_on_google_places_id", unique: true
    t.index ["submitter_id"], name: "index_listings_on_submitter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "role", null: false
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "currencies_listings", "currencies"
  add_foreign_key "currencies_listings", "listings"
  add_foreign_key "listings", "users", column: "submitter_id"
end
