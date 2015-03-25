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

ActiveRecord::Schema.define(version: 20150325123410) do

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "read",       default: false
    t.string   "content"
    t.integer  "order_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "deadline"
    t.string   "location"
    t.string   "phone"
    t.string   "status"
    t.integer  "server"
    t.decimal  "total",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "orders", ["deadline"], name: "index_orders_on_deadline"
  add_index "orders", ["location"], name: "index_orders_on_location"
  add_index "orders", ["phone"], name: "index_orders_on_phone"
  add_index "orders", ["server"], name: "index_orders_on_server"
  add_index "orders", ["status"], name: "index_orders_on_status"
  add_index "orders", ["title"], name: "index_orders_on_title"
  add_index "orders", ["total"], name: "index_orders_on_total"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
