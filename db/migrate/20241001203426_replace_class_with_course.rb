class ReplaceClassWithCourse < ActiveRecord::Migration[7.0]
  def change
    rename_table :class_requests, :course_requests
    rename_table :class_request_statuses, :course_request_statuses
    rename_table :class_reviews, :course_reviews
  end
end
