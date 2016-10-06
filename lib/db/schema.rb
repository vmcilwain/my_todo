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

ActiveRecord::Schema.define(version: 20161005133023) do

  create_table "items", force: :cascade do |t|
    t.string   "body"
    t.boolean  "done"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "detailed_status"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "item_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_notes_on_item_id"
  end

  create_table "stubs", force: :cascade do |t|
    t.integer "item_id"
    t.integer "tag_id"
    t.index ["item_id"], name: "index_stubs_on_item_id"
    t.index ["tag_id"], name: "index_stubs_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_tags_on_name"
  end

end
