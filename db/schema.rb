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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120413142351) do

  create_table "events", :force => true do |t|
    t.string   "title"
    t.integer  "num_quizzes"
    t.string   "filename"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_types", :force => true do |t|
    t.string   "name"
    t.integer  "question_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "written_by"
    t.integer  "approved_by"
    t.integer  "question_category_id"
    t.integer  "section_id"
    t.string   "book"
    t.integer  "chapter"
    t.string   "verse"
    t.string   "text"
    t.string   "answer"
    t.integer  "keyword"
    t.datetime "created_on"
    t.datetime "approved_on"
    t.integer  "approval_level"
    t.string   "approval_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_type_id"
    t.integer  "position"
    t.integer  "difficulty_ranking"
  end

  create_table "quiz_questions", :force => true do |t|
    t.integer  "quiz_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "quiz_sections", :force => true do |t|
    t.integer  "quiz_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "filename"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question_categories"
    t.integer  "interrogative"
    t.integer  "finish_the_verse"
    t.integer  "quote"
    t.integer  "reference"
    t.integer  "multiple_answer"
    t.integer  "situation"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "book"
    t.integer  "chapter"
    t.integer  "start_verse"
    t.integer  "end_verse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
