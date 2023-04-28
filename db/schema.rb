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

ActiveRecord::Schema[7.0].define(version: 2023_04_28_080313) do
  create_table "blind_dates", force: :cascade do |t|
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mapping_employee_teams", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "employee_id", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_mapping_employee_teams_on_employee_id"
    t.index ["team_id", "employee_id"], name: "index_mapping_employee_teams_on_team_id_and_employee_id", unique: true
    t.index ["team_id"], name: "index_mapping_employee_teams_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blind_date_id", null: false
    t.index ["blind_date_id"], name: "index_teams_on_blind_date_id"
  end

  add_foreign_key "mapping_employee_teams", "employees"
  add_foreign_key "mapping_employee_teams", "teams"
  add_foreign_key "teams", "blind_dates"
end
