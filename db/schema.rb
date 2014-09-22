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

ActiveRecord::Schema.define(version: 20140918223248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "trello_cards", force: true do |t|
    t.integer  "card_number"
    t.string   "card_name"
    t.string   "card_link"
    t.integer  "trello_release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trello_cards", ["trello_release_id"], name: "index_trello_cards_on_trello_release_id", using: :btree

  create_table "trello_releases", force: true do |t|
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
