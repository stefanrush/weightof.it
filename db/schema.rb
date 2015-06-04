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

ActiveRecord::Schema.define(version: 20150521051923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "slug",                       null: false
    t.integer  "position",   default: 0,     null: false
    t.boolean  "active",     default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "libraries", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "slug",                              null: false
    t.integer  "weight"
    t.string   "source_url",                        null: false
    t.string   "homepage_url"
    t.string   "description"
    t.integer  "popularity"
    t.integer  "category_id",                       null: false
    t.boolean  "check_description", default: false, null: false
    t.boolean  "check_popularity",  default: false, null: false
    t.boolean  "active",            default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "libraries", ["category_id"], name: "index_libraries_on_category_id", using: :btree
  add_index "libraries", ["slug"], name: "index_libraries_on_slug", using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "library_id",                   null: false
    t.string   "number",                       null: false
    t.string   "raw_url",                      null: false
    t.integer  "weight"
    t.boolean  "check_weight", default: false, null: false
    t.boolean  "active",       default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "versions", ["library_id"], name: "index_versions_on_library_id", using: :btree

end
