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

ActiveRecord::Schema.define(version: 20130927234206) do

  create_table "customer_order_items", force: true do |t|
    t.integer  "customer_order_id"
    t.integer  "menu_item_id"
    t.boolean  "is_menu_item_ready"
    t.text     "waitstaff_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_orders", force: true do |t|
    t.integer  "table_id"
    t.boolean  "is_order_ready"
    t.boolean  "is_order_paid_for"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_tables", force: true do |t|
    t.integer  "employee_id"
    t.integer  "table_id"
    t.datetime "assign_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_types", force: true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "employee_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", force: true do |t|
    t.string   "item_name"
    t.decimal  "item_price"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "menu_name"
    t.float    "start_time"
    t.float    "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: true do |t|
    t.string   "table_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
