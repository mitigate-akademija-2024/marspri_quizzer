# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_14_093422) do
  create_table "answers", force: :cascade do |t|
    t.integer "question_id"
    t.string "answer_text", null: false
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quiz_id"
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.text "feedback"
    t.index ["creator_id"], name: "index_quizzes_on_creator_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "quiz_id", null: false
    t.integer "user_id", null: false
    t.float "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "user_answers"
    t.text "feedback"
    t.string "feedback_type"
    t.index ["feedback_type"], name: "index_results_on_feedback_type"
    t.index ["quiz_id"], name: "index_results_on_quiz_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quizzes", "users", column: "creator_id"
  add_foreign_key "results", "quizzes"
  add_foreign_key "results", "users"
end
