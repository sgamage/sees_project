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

ActiveRecord::Schema.define(:version => 20120722045035) do

  create_table "answers", :force => true do |t|
    t.string   "answer_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_support_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "student_id"
    t.text     "comment_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "courses", :force => true do |t|
    t.string  "name"
    t.integer "faculty_id"
  end

  create_table "faculties", :force => true do |t|
    t.string  "name"
    t.integer "school_id"
  end

  create_table "feedback_question_answers", :force => true do |t|
    t.integer "feedback_id"
    t.integer "question_id"
    t.integer "answer_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "user_id"
    t.integer  "school_id"
    t.string   "answers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "support_student",               :default => false
    t.integer  "application_support_status_id"
    t.text     "application_support_comment"
    t.text     "extra_note"
    t.boolean  "read_confirmation",             :default => false
    t.string   "recommandation_level"
  end

  create_table "questions", :force => true do |t|
    t.integer  "category_id"
    t.string   "question_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string "name"
    t.string "principal_title"
    t.string "principal_firstname"
    t.string "principal_surname"
    t.string "position"
    t.string "address"
    t.string "suburb"
    t.string "state"
    t.string "postcode"
    t.string "phone"
    t.string "email"
    t.string "category"
  end

  create_table "states", :force => true do |t|
    t.string "name"
  end

  create_table "student_files", :force => true do |t|
    t.string  "name"
    t.integer "student_id"
  end

  create_table "students", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "parent_name"
    t.string   "parent_phone"
    t.string   "parent_mobile"
    t.string   "uac_number"
    t.string   "email"
    t.string   "confirm_email"
    t.string   "mobile"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "suburb"
    t.integer  "state_id"
    t.string   "post_code"
    t.integer  "school_id"
    t.integer  "faculty_id"
    t.integer  "course_id"
    t.string   "note1"
    t.string   "note2"
    t.string   "note3"
    t.boolean  "declaration1"
    t.boolean  "declaration2"
    t.boolean  "declaration3"
    t.boolean  "declaration4"
    t.boolean  "completed",             :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "acceptance",            :default => 0
    t.integer  "application_status_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",        :null => false
    t.string   "encrypted_password",     :default => "",        :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "user_type",              :default => "STUDENT"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
