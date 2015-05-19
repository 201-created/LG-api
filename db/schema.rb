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

ActiveRecord::Schema.define(version: 20150519001931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cv_requests", force: :cascade do |t|
    t.integer  "uploading_organization_id", null: false
    t.integer  "image_set_id",              null: false
    t.string   "status"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "server_uuid"
  end

  add_index "cv_requests", ["image_set_id"], name: "index_cv_requests_on_image_set_id", using: :btree
  add_index "cv_requests", ["uploading_organization_id", "status"], name: "index_cv_requests_on_uploading_organization_id_and_status", using: :btree

  create_table "cv_results", force: :cascade do |t|
    t.integer  "cv_request_id",     null: false
    t.float    "match_probability", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "lion_id"
  end

  add_index "cv_results", ["cv_request_id"], name: "index_cv_results_on_cv_request_id", using: :btree
  add_index "cv_results", ["lion_id"], name: "index_cv_results_on_lion_id", using: :btree

  create_table "image_sets", force: :cascade do |t|
    t.integer  "lion_id"
    t.integer  "main_image_id"
    t.integer  "uploading_organization_id",                                          null: false
    t.integer  "uploading_user_id",                                                  null: false
    t.integer  "owner_organization_id"
    t.boolean  "is_verified",                                        default: false, null: false
    t.decimal  "latitude",                  precision: 10, scale: 6
    t.decimal  "decimal",                   precision: 10, scale: 6
    t.decimal  "longitude",                 precision: 10, scale: 6
    t.datetime "photo_date"
    t.string   "gender"
    t.boolean  "is_primary",                                         default: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.datetime "date_of_birth"
    t.string   "tags",                                                                            array: true
  end

  add_index "image_sets", ["tags"], name: "index_image_sets_on_tags", using: :gin

  create_table "images", force: :cascade do |t|
    t.string   "image_type"
    t.integer  "image_set_id"
    t.boolean  "is_public",    default: false
    t.string   "url",                          null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_deleted",   default: false
  end

  add_index "images", ["image_set_id", "is_deleted"], name: "index_images_on_image_set_id_and_is_deleted", where: "(is_deleted IS NOT TRUE)", using: :btree

  create_table "lions", force: :cascade do |t|
    t.string   "name",                 null: false
    t.integer  "organization_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "primary_image_set_id"
  end

  add_index "lions", ["name"], name: "index_lions_on_name", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                default: "", null: false
    t.integer  "organization_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "encrypted_password",   default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "authentication_token"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
