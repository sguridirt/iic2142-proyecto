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

ActiveRecord::Schema[7.0].define(version: 2024_10_15_184234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.boolean "is_group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_request_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_requests", force: :cascade do |t|
    t.string "description", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id", null: false
    t.bigint "course_request_status_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_course_requests_on_course_id"
    t.index ["course_request_status_id"], name: "index_course_requests_on_course_request_status_id"
    t.index ["student_id"], name: "index_course_requests_on_student_id"
  end

  create_table "course_reviews", force: :cascade do |t|
    t.string "title", null: false
    t.string "comment", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_course_reviews_on_course_id"
    t.index ["student_id"], name: "index_course_reviews_on_student_id"
  end

  create_table "course_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teacher_id", null: false
    t.bigint "course_type_id", null: false
    t.index ["course_type_id"], name: "index_courses_on_course_type_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.date "enrollment_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "evaluation_answers", force: :cascade do |t|
    t.string "content", null: false
    t.integer "points", null: false
    t.integer "evaluation_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evaluation_question_id"
    t.bigint "student_id"
    t.index ["evaluation_question_id"], name: "index_evaluation_answers_on_evaluation_question_id"
    t.index ["student_id"], name: "index_evaluation_answers_on_student_id"
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
    t.date "start_date", null: false
    t.integer "duration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.bigint "evaluation_type_id"
    t.index ["course_id"], name: "index_evaluations_on_course_id"
    t.index ["evaluation_type_id"], name: "index_evaluations_on_evaluation_type_id"
  end

  create_table "material_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "material_type_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_materials_on_course_id"
    t.index ["material_type_id"], name: "index_materials_on_material_type_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teacher_reviews", force: :cascade do |t|
    t.string "title", null: false
    t.string "comment", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id", null: false
    t.bigint "teacher_id", null: false
    t.index ["student_id"], name: "index_teacher_reviews_on_student_id"
    t.index ["teacher_id"], name: "index_teacher_reviews_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "profile_picture_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_role_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "users", on_delete: :cascade
  add_foreign_key "conversation_messages", "conversation_participants", column: "sender_id", on_delete: :cascade
  add_foreign_key "conversation_messages", "conversations"
  add_foreign_key "conversation_participants", "conversations"
  add_foreign_key "conversation_participants", "users"
  add_foreign_key "course_requests", "course_request_statuses"
  add_foreign_key "course_requests", "courses"
  add_foreign_key "course_requests", "students"
  add_foreign_key "course_reviews", "courses"
  add_foreign_key "course_reviews", "students"
  add_foreign_key "courses", "course_types"
  add_foreign_key "courses", "teachers"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "evaluation_answers", "evaluation_questions", on_delete: :cascade
  add_foreign_key "evaluation_answers", "students"
  add_foreign_key "evaluation_questions", "evaluations", on_delete: :cascade
  add_foreign_key "evaluations", "courses", on_delete: :cascade
  add_foreign_key "evaluations", "evaluation_types"
  add_foreign_key "materials", "courses"
  add_foreign_key "materials", "material_types"
  add_foreign_key "students", "users", on_delete: :cascade
  add_foreign_key "teacher_reviews", "students", on_delete: :cascade
  add_foreign_key "teacher_reviews", "teachers"
  add_foreign_key "teachers", "users", on_delete: :cascade
  add_foreign_key "users", "user_roles"
end
