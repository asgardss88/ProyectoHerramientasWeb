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

ActiveRecord::Schema.define(version: 20130522020209) do

  create_table "answer_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_comments", ["answer_id"], name: "index_answer_comments_on_answer_id"
  add_index "answer_comments", ["user_id"], name: "index_answer_comments_on_user_id"

  create_table "answers", force: true do |t|
    t.text     "content"
    t.integer  "votes"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "state"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "assigned_tags", force: true do |t|
    t.integer  "question_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assigned_tags", ["question_id"], name: "index_assigned_tags_on_question_id"
  add_index "assigned_tags", ["tag_id"], name: "index_assigned_tags_on_tag_id"

  create_table "question_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_comments", ["question_id"], name: "index_question_comments_on_question_id"
  add_index "question_comments", ["user_id"], name: "index_question_comments_on_user_id"

  create_table "questions", force: true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.integer  "votes"
    t.integer  "bonus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ask_for"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "",    null: false
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "points",                             default: 0
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vote_answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vote_answers", ["answer_id"], name: "index_vote_answers_on_answer_id"
  add_index "vote_answers", ["user_id"], name: "index_vote_answers_on_user_id"

  create_table "vote_questions", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vote_questions", ["question_id"], name: "index_vote_questions_on_question_id"
  add_index "vote_questions", ["user_id"], name: "index_vote_questions_on_user_id"

end
