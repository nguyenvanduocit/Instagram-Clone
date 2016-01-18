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

ActiveRecord::Schema.define(version: 20160118182206) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtag_relationships", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "hashtag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hashtag_relationships", ["hashtag_id"], name: "index_hashtag_relationships_on_hashtag_id"
  add_index "hashtag_relationships", ["post_id", "hashtag_id"], name: "index_hashtag_relationships_on_post_id_and_hashtag_id", unique: true
  add_index "hashtag_relationships", ["post_id"], name: "index_hashtag_relationships_on_post_id"

  create_table "hashtags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hashtags", ["name"], name: "index_hashtags_on_name", unique: true

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "views_count",    default: 0
    t.integer  "likes_count",    default: 0
    t.integer  "comments_count", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "role_relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "role_relationships", ["role_id"], name: "index_role_relationships_on_role_id"
  add_index "role_relationships", ["user_id", "role_id"], name: "index_role_relationships_on_user_id_and_role_id", unique: true
  add_index "role_relationships", ["user_id"], name: "index_role_relationships_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
