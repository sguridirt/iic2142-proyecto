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

ActiveRecord::Schema[7.0].define(version: 2024_09_30_163959) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "conversation_messages", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "sender_id", null: false
    t.string "content"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_conversation_messages_on_conversation_id"
    t.index ["sender_id"], name: "index_conversation_messages_on_sender_id"
  end

  create_table "conversation_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "conversation_id", null: false
    t.date "joined_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_conversation_participants_on_conversation_id"
    t.index ["user_id"], name: "index_conversation_participants_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.boolean "is_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "profilePictureURL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_role_id", null: false
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  
  
  create_table "class_reviews", force: :cascade do |t|
    t.string "title", null: false
    t.string "comment", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluation_answers", force: :cascade do |t|
    t.string "content", null: false
    t.integer "points", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluation_questions", force: :cascade do |t|
    t.json "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_id", null: false
    t.index ["evaluation_id"], name: "index_evaluation_questions_on_evaluation_id"
  end

  create_table "evaluation_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.string "name", null: false
    t.date "startDate", null: false
    t.integer "duration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_reviews", force: :cascade do |t|
    t.string "title", null: false
    t.string "comment", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  
  add_foreign_key "admins", "users", on_delete: :cascade
  add_foreign_key "conversation_messages", "conversation_participants", column: "sender_id", on_delete: :cascade
  add_foreign_key "conversation_messages", "conversations"
  add_foreign_key "conversation_participants", "conversations"
  add_foreign_key "conversation_participants", "users"
  add_foreign_key "students", "users", on_delete: :cascade
  add_foreign_key "teachers", "users", on_delete: :cascade
  add_foreign_key "users", "user_roles"
  add_foreign_key "evaluation_questions", "evaluations", on_delete: :cascade
end
