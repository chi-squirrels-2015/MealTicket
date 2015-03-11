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

ActiveRecord::Schema.define(version: 20150311150439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "owners", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "owners", ["email"], name: "index_owners_on_email", unique: true, using: :btree
  add_index "owners", ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true, using: :btree

  create_table "promotions", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.integer  "min_group_size"
    t.integer  "max_group_size"
    t.integer  "preferred_group_size"
    t.float    "loss_tolerance"
    t.float    "available_budget"
    t.float    "min_spend"
    t.float    "max_discount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",               default: true
    t.date     "valid_on"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "ticket_id"
    t.string   "purchaser_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "confirmation_id"
    t.boolean  "paid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "yelp_id"
    t.string   "name"
    t.string   "display_phone"
    t.string   "address"
    t.string   "zipcode"
    t.string   "cuisine"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "owner_id"
    t.string   "email"
    t.string   "password_digest"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "promotion_id"
    t.float    "discount"
    t.float    "min_total_spend"
    t.integer  "group_size"
    t.boolean  "active"
    t.float    "ticket_price"
    t.float    "loss_per_ticket"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
