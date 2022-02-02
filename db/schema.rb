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

ActiveRecord::Schema.define(version: 2022_01_30_162032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.bigint "week_id"
    t.string "name_day"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["week_id"], name: "index_days_on_week_id"
  end

  create_table "hours", force: :cascade do |t|
    t.bigint "day_id"
    t.bigint "service_id"
    t.time "hour_start"
    t.time "hour_end"
    t.string "name_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_id"], name: "index_hours_on_day_id"
    t.index ["service_id"], name: "index_hours_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "day_hour_start"
    t.string "day_hour_end"
    t.integer "hour_range"
    t.integer "monday_hour_start"
    t.integer "monday_hour_end"
    t.integer "tuesday_hour_start"
    t.integer "tuesday_hour_end"
    t.integer "wednesday_hour_start"
    t.integer "wednesday_hour_end"
    t.integer "thursday_hour_start"
    t.integer "thursday_hour_end"
    t.integer "friday_hour_start"
    t.integer "friday_hour_end"
    t.integer "saturday_hour_start"
    t.integer "saturday_hour_end"
    t.integer "sunday_hour_start"
    t.integer "sunday_hour_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_availabilities", force: :cascade do |t|
    t.bigint "hour_id"
    t.bigint "user_id"
    t.boolean "available", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hour_id"], name: "index_user_availabilities_on_hour_id"
    t.index ["user_id"], name: "index_user_availabilities_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "user_id"
    t.boolean "available", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_user_services_on_service_id"
    t.index ["user_id"], name: "index_user_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "color"
    t.integer "age"
    t.string "gender"
    t.string "user_role"
    t.string "phone_number"
    t.date "date_of_birth"
    t.string "profile_picture"
    t.string "fb_id"
    t.string "fb_token"
    t.string "google_id"
    t.string "google_token"
    t.string "apple_id"
    t.text "access_token"
    t.text "password"
    t.text "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.bigint "service_id"
    t.string "name_week"
    t.integer "number_week"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_weeks_on_service_id"
  end

  add_foreign_key "days", "weeks"
  add_foreign_key "hours", "days"
  add_foreign_key "hours", "services"
  add_foreign_key "user_availabilities", "hours"
  add_foreign_key "user_availabilities", "users"
  add_foreign_key "user_services", "services"
  add_foreign_key "user_services", "users"
  add_foreign_key "weeks", "services"
end
