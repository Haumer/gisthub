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

ActiveRecord::Schema.define(version: 2020_07_01_010442) do

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
    t.index ["user_id"], name: "index_gists_on_user_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "gist_files", "gists"
  add_foreign_key "gists", "users"
end
