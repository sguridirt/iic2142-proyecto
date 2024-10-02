class RemovePlurals < ActiveRecord::Migration[7.0]
  def change
    rename_column :course_requests, :students_id, :student_id
    rename_column :course_requests, :courses_id, :course_id
    rename_column :course_requests, :class_request_statuses_id, :class_request_status_id

    rename_column :courses, :teachers_id, :teacher_id
    rename_column :courses, :class_types_id, :course_type_id

    rename_column :enrollments, :students_id, :student_id

    rename_column :evaluation_answers, :status, :evaluation_status

    rename_column :materials, :material_types_id, :material_type_id
  end
end
