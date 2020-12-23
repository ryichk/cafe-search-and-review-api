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

ActiveRecord::Schema.define(version: 20180613230541) do

  create_table "like_places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "place_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_like_places_on_place_id"
    t.index ["user_id", "place_id"], name: "index_like_places_on_user_id_and_place_id", unique: true
    t.index ["user_id"], name: "index_like_places_on_user_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id", "review_id"], name: "index_likes_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.string "notified_type"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "notified_by_id"
    t.index ["notified_by_id"], name: "index_notifications_on_notified_by_id"
    t.index ["review_id"], name: "index_notifications_on_review_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photos"
    t.integer "like_places_count", null: false
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "review"
    t.integer "rank"
    t.integer "user_id"
    t.integer "place_id"
    t.json "photos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.integer "likes_count", default: 0, null: false
    t.string "photos_tmp"
    t.integer "smoke"
    t.integer "wifi"
    t.integer "elec"
    t.integer "menu"
    t.integer "coffee"
    t.integer "cost"
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.boolean "agreement"
    t.string "avatar"
    t.string "avatar_url"
    t.string "avatar_url_tmp"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "notifications", "reviews"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
end
