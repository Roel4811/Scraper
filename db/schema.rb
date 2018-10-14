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

ActiveRecord::Schema.define(version: 20181012145130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands_searches", id: false, force: :cascade do |t|
    t.integer "search_id"
    t.integer "brand_id"
    t.index ["brand_id", "search_id"], name: "index_brands_searches_on_brand_id_and_search_id", unique: true
    t.index ["search_id"], name: "index_brands_searches_on_search_id"
  end

  create_table "contact_submissions", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "image"
    t.string "link"
    t.string "rating"
    t.integer "review_amount"
    t.bigint "store_id"
    t.boolean "available"
    t.string "availability"
    t.integer "provider_id"
    t.boolean "issue"
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
  end

  create_table "providers_searches", id: false, force: :cascade do |t|
    t.integer "search_id"
    t.integer "provider_id"
    t.index ["provider_id", "search_id"], name: "index_providers_searches_on_provider_id_and_search_id", unique: true
    t.index ["search_id"], name: "index_providers_searches_on_search_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keywords"
    t.decimal "min_price"
    t.decimal "max_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "brands"
  add_foreign_key "products", "providers"
end
