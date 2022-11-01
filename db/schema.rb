# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_31_150018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parameters", force: :cascade do |t|
    t.string "name"
    t.string "measuring_unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  create_table "records", force: :cascade do |t|
    t.bigint "station_id", null: false
    t.bigint "parameter_id", null: false
    t.datetime "time"
    t.decimal "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parameter_id"], name: "index_records_on_parameter_id"
    t.index ["station_id"], name: "index_records_on_station_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  add_foreign_key "records", "parameters"
  add_foreign_key "records", "stations"
end
