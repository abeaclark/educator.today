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

ActiveRecord::Schema.define(version: 20160329174749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.string   "vanity_link"
    t.string   "photo_url"
    t.string   "summary"
    t.integer  "user_id"
    t.string   "username"
    t.integer  "upvotes",            default: 0
    t.float    "score",              default: 0.0
    t.boolean  "current_user_voted"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "id_token"
    t.string   "uid",        null: false
    t.string   "name"
    t.string   "location"
    t.string   "email"
    t.string   "image_url"
    t.string   "gender"
    t.string   "url"
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
  end

  add_index "votes", ["user_id", "post_id"], name: "index_votes_on_user_id_and_post_id", unique: true, using: :btree

end
