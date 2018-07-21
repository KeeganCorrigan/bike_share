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

ActiveRecord::Schema.define(version: 20180721204311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "status", default: 0
    t.string "image_url"
    t.string "description"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "end_date"
    t.integer "max_temperature"
    t.integer "mean_temperature"
    t.integer "min_temperature"
    t.integer "mean_humididity"
    t.integer "mean_visibility"
    t.integer "mean_wind_speed"
    t.integer "precipitation"
  end

  create_table "order_accessories", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "accessory_id"
    t.index ["accessory_id"], name: "index_order_accessories_on_accessory_id"
    t.index ["order_id"], name: "index_order_accessories_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.string "installation_date"
    t.string "slug"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.string "start_date"
    t.integer "start_station_id"
    t.string "end_date"
    t.integer "end_station_id"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "password"
    t.integer "role", default: 0
  end

  add_foreign_key "order_accessories", "accessories"
  add_foreign_key "order_accessories", "orders"
  add_foreign_key "orders", "users"
end
