# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_05_100450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gist_files", force: :cascade do |t|
    t.bigint "gist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "filename", default: ""
    t.string "raw_url", default: ""
    t.integer "size", default: 0
    t.string "language", default: ""
    t.index ["gist_id"], name: "index_gist_files_on_gist_id"
  end

  create_table "gist_labels", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "gist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gist_id"], name: "index_gist_labels_on_gist_id"
    t.index ["label_id"], name: "index_gist_labels_on_label_id"
  end

  create_table "gists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url", default: "", null: false
    t.string "forks_url", default: "", null: false
    t.string "html_url", default: "", null: false
    t.boolean "public", default: true, null: false
    t.string "description", default: ""
    t.integer "comments", default: 0, null: false
    t.string "comments_url", default: "", null: false
    t.string "date", default: "", null: false
    t.string "gist_id", default: "", null: false
    t.boolean "hide", default: true
    t.boolean "star", default: true
    t.index ["user_id"], name: "index_gists_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "img_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usergroups", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_usergroups_on_group_id"
    t.index ["user_id"], name: "index_usergroups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "githubname", default: "", null: false
    t.string "avatar_url", default: ""
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "gist_files", "gists"
  add_foreign_key "gist_labels", "gists"
  add_foreign_key "gist_labels", "labels"
  add_foreign_key "gists", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "labels", "users"
  add_foreign_key "usergroups", "groups"
  add_foreign_key "usergroups", "users"
end
