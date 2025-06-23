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

ActiveRecord::Schema[8.0].define(version: 2025_06_23_072637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "group_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_group_memberships_on_employee_id"
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reporting_relationships", force: :cascade do |t|
    t.bigint "subordinate_id", null: false
    t.string "supervisor_type", null: false
    t.bigint "supervisor_id", null: false
    t.string "connection_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subordinate_id"], name: "index_reporting_relationships_on_subordinate_id"
    t.index ["supervisor_type", "supervisor_id"], name: "index_reporting_relationships_on_supervisor"
  end

  add_foreign_key "group_memberships", "employees"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "reporting_relationships", "employees", column: "subordinate_id"
end
