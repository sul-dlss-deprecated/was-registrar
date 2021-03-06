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

ActiveRecord::Schema.define(version: 20150916223728) do

  create_table "crawl_items", force: :cascade do |t|
    t.string "druid_id"
    t.string "job_directory"
    t.string "collection_id"
    t.boolean "on_disk"
    t.date "registered_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_id"
    t.string "apo_id"
  end

  create_table "seed_items", force: :cascade do |t|
    t.string "druid_id"
    t.string "uri"
    t.boolean "embargo"
    t.string "source"
    t.string "collection_id"
    t.text "source_xml"
    t.string "source_file"
    t.date "import_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.string "source_id"
    t.string "rights"
    t.string "apo_id"
  end

end
