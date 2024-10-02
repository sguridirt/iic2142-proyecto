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

ActiveRecord::Schema[7.0].define(version: 2024_10_01_202441) do
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

  create_table "class_request_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "class_requests", force: :cascade do |t|
    t.string "description", null: false
    t.date "startDate", null: false
    t.date "endaDate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "students_id", null: false
    t.bigint "class_request_statuses_id", null: false
    t.bigint "courses_id", null: false
    t.index ["class_request_statuses_id"], name: "index_class_requests_on_class_request_statuses_id"
    t.index ["courses_id"], name: "index_class_requests_on_courses_id"
    t.index ["students_id"], name: "index_class_requests_on_students_id"
  end

  create_table "class_reviews", force: :cascade do |t|
    t.string "title", null: false
    t.string "comment", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "class_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "course_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.date "startDate", null: false
    t.date "endDate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teachers_id", null: false
    t.bigint "class_types_id", null: false
    t.index ["class_types_id"], name: "index_courses_on_class_types_id"
    t.index ["teachers_id"], name: "index_courses_on_teachers_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.date "enrollmentDate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "courses_id", null: false
    t.bigint "students_id", null: false
    t.index ["courses_id"], name: "index_enrollments_on_courses_id"
    t.index ["students_id"], name: "index_enrollments_on_students_id"
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
    t.bigint "material_types_id", null: false
    t.index ["material_types_id"], name: "index_materials_on_material_types_id"
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
    t.string "profilePictureURL"
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
  add_foreign_key "class_requests", "class_request_statuses", column: "class_request_statuses_id"
  add_foreign_key "class_requests", "courses", column: "courses_id"
  add_foreign_key "class_requests", "students", column: "students_id"
  add_foreign_key "conversation_messages", "conversation_participants", column: "sender_id", on_delete: :cascade
  add_foreign_key "conversation_messages", "conversations"
  add_foreign_key "conversation_participants", "conversations"
  add_foreign_key "conversation_participants", "users"
  add_foreign_key "courses", "course_types", column: "class_types_id"
  add_foreign_key "courses", "teachers", column: "teachers_id"
  add_foreign_key "enrollments", "courses", column: "courses_id"
  add_foreign_key "enrollments", "students", column: "students_id"
  add_foreign_key "evaluation_questions", "evaluations", on_delete: :cascade
  add_foreign_key "materials", "material_types", column: "material_types_id"
  add_foreign_key "students", "users", on_delete: :cascade
  add_foreign_key "teachers", "users", on_delete: :cascade
  add_foreign_key "users", "user_roles"
end
