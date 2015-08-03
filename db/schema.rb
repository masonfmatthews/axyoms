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

ActiveRecord::Schema.define(version: 20150803001956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignment_coverages", force: :cascade do |t|
    t.integer  "assignment_id"
    t.uuid     "concept_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignment_coverages", ["assignment_id"], name: "index_assignment_coverages_on_assignment_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graph_caches", force: :cascade do |t|
    t.text     "parentage_depth_cache"
    t.text     "precedence_depth_cache"
    t.text     "parentage_structure_cache"
    t.text     "precedence_link_cache"
    t.text     "all_link_cache"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", force: :cascade do |t|
    t.integer  "student_id"
    t.uuid     "concept_uuid"
    t.integer  "assignment_id"
    t.boolean  "positive"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "references", force: :cascade do |t|
    t.uuid     "concept_uuid"
    t.string   "uri"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
  end

  add_index "scores", ["assignment_id"], name: "index_scores_on_assignment_id", using: :btree
  add_index "scores", ["student_id"], name: "index_scores_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_coverages", force: :cascade do |t|
    t.integer  "unit_id"
    t.uuid     "concept_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unit_coverages", ["unit_id"], name: "index_unit_coverages_on_unit_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
