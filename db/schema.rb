# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 15) do

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "events_locations", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "location_id"
  end

  add_index "events_locations", ["event_id"], name: "index_events_locations_on_event_id"
  add_index "events_locations", ["location_id"], name: "index_events_locations_on_location_id"

  create_table "joins", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "joins", ["event_id"], name: "index_joins_on_event_id"
  add_index "joins", ["user_id"], name: "index_joins_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "coordinates"
    t.string   "tag"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "owned_events", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "owned_events", ["event_id"], name: "index_owned_events_on_event_id"
  add_index "owned_events", ["user_id"], name: "index_owned_events_on_user_id"

  create_table "owned_locations", id: false, force: :cascade do |t|
    t.integer "location_id"
    t.integer "user_id"
  end

  add_index "owned_locations", ["location_id"], name: "index_owned_locations_on_location_id"
  add_index "owned_locations", ["user_id"], name: "index_owned_locations_on_user_id"

  create_table "permissions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  add_index "permissions_roles", ["permission_id"], name: "index_permissions_roles_on_permission_id"
  add_index "permissions_roles", ["role_id"], name: "index_permissions_roles_on_role_id"

  create_table "permissions_tasks", id: false, force: :cascade do |t|
    t.integer "permission_id"
    t.integer "task_id"
  end

  add_index "permissions_tasks", ["permission_id"], name: "index_permissions_tasks_on_permission_id"
  add_index "permissions_tasks", ["task_id"], name: "index_permissions_tasks_on_task_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id"
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "request_method"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "visits", ["location_id"], name: "index_visits_on_location_id"
  add_index "visits", ["user_id"], name: "index_visits_on_user_id"

end
