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

ActiveRecord::Schema.define(version: 2020_12_12_035748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gist_file_languages", force: :cascade do |t|
    t.bigint "gist_file_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gist_file_id"], name: "index_gist_file_languages_on_gist_file_id"
    t.index ["language_id"], name: "index_gist_file_languages_on_language_id"
  end

  create_table "gist_files", force: :cascade do |t|
    t.bigint "user_gist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "filename", default: ""
    t.string "raw_url", default: ""
    t.integer "size", default: 0
    t.string "raw_code"
    t.boolean "markdown_display", default: false
    t.index ["user_gist_id"], name: "index_gist_files_on_user_gist_id"
  end

  create_table "gist_labels", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "user_gist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["label_id"], name: "index_gist_labels_on_label_id"
    t.index ["user_gist_id"], name: "index_gist_labels_on_user_gist_id"
  end

  create_table "group_gists", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_gist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_gists_on_group_id"
    t.index ["user_gist_id"], name: "index_group_gists_on_user_gist_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", default: ""
    t.string "alias"
    t.string "color", default: "#000000"
    t.boolean "public_group", default: true
    t.boolean "personal", default: false
    t.text "description", default: ""
    t.integer "page_counter"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "img_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rouge_name"
  end

  create_table "user_gists", force: :cascade do |t|
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
    t.boolean "hide", default: false
    t.boolean "star", default: false
    t.string "title", default: ""
    t.index ["user_id"], name: "index_user_gists_on_user_id"
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
    t.string "avatar_url", default: "https://avatars3.githubusercontent.com/u/583231?v=4"
    t.string "provider"
    t.string "uid"
    t.boolean "admin", default: false
    t.boolean "auto_import", default: true
    t.boolean "stop_import", default: false
    t.boolean "only_group_import", default: false
    t.string "github_token"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "markdown_permission", default: false
    t.integer "page_counter"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "gist_file_languages", "gist_files"
  add_foreign_key "gist_file_languages", "languages"
  add_foreign_key "gist_files", "user_gists"
  add_foreign_key "gist_labels", "labels"
  add_foreign_key "gist_labels", "user_gists"
  add_foreign_key "group_gists", "groups"
  add_foreign_key "group_gists", "user_gists"
  add_foreign_key "groups", "users"
  add_foreign_key "labels", "users"
  add_foreign_key "user_gists", "users"
  add_foreign_key "usergroups", "groups"
  add_foreign_key "usergroups", "users"
end
