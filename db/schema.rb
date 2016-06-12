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

ActiveRecord::Schema.define(version: 20160612224805) do

  create_table "gfiles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "size"
    t.integer  "infohash_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "gfiles", ["infohash_id"], name: "index_gfiles_on_infohash_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "htypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "infohashes", force: :cascade do |t|
    t.string   "code"
    t.integer  "visibility_id"
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "htype_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "infohashes", ["group_id"], name: "index_infohashes_on_group_id"
  add_index "infohashes", ["htype_id"], name: "index_infohashes_on_htype_id"
  add_index "infohashes", ["user_id"], name: "index_infohashes_on_user_id"
  add_index "infohashes", ["visibility_id"], name: "index_infohashes_on_visibility_id"

  create_table "inforelations", force: :cascade do |t|
    t.integer  "infohash1_id"
    t.integer  "infohash2_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "instances", force: :cascade do |t|
    t.string   "name"
    t.string   "pubKey"
    t.datetime "pubKeyExpiration"
    t.string   "address"
    t.boolean  "allowAutomaticPull"
    t.boolean  "allowPull"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "infohash_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "members", ["infohash_id"], name: "index_members_on_infohash_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "news", force: :cascade do |t|
    t.integer  "infohash_id"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "news", ["infohash_id"], name: "index_news_on_infohash_id"

  create_table "pauthors", force: :cascade do |t|
    t.integer  "publication_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "pauthors", ["publication_id"], name: "index_pauthors_on_publication_id"
  add_index "pauthors", ["user_id"], name: "index_pauthors_on_user_id"

  create_table "pkeywords", force: :cascade do |t|
    t.integer  "publication_id"
    t.integer  "infohash_id"
    t.string   "keyword"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "pkeywords", ["infohash_id"], name: "index_pkeywords_on_infohash_id"
  add_index "pkeywords", ["publication_id"], name: "index_pkeywords_on_publication_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "infohash_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["infohash_id"], name: "index_projects_on_infohash_id"

  create_table "publications", force: :cascade do |t|
    t.integer  "ptype"
    t.string   "title"
    t.string   "journal"
    t.integer  "year"
    t.string   "doi"
    t.text     "other"
    t.integer  "infohash_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "publications", ["infohash_id"], name: "index_publications_on_infohash_id"

  create_table "tags", force: :cascade do |t|
    t.string   "tagname"
    t.integer  "infohash_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tags", ["infohash_id"], name: "index_tags_on_infohash_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "visibilities", force: :cascade do |t|
    t.string   "vtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end