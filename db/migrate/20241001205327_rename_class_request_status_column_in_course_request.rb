class RenameClassRequestStatusColumnInCourseRequest < ActiveRecord::Migration[7.0]
  def change
    rename_column :course_requests, :class_request_status_id, :course_request_status_id
  end
end
