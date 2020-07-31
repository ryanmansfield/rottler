# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_30_234825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "technicians", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.bigint "technician_id", null: false
    t.bigint "work_order_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "duration"
    t.boolean "is_booked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technician_id"], name: "index_time_slots_on_technician_id"
    t.index ["work_order_id"], name: "index_time_slots_on_work_order_id"
  end

  create_table "work_orders", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "duration"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_work_orders_on_location_id"
  end

  add_foreign_key "time_slots", "technicians"
  add_foreign_key "time_slots", "work_orders"
  add_foreign_key "work_orders", "locations"
end
