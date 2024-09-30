class AddForeignKeysToClassRequest < ActiveRecord::Migration[7.0]
  def change
    add_reference :class_requests, :students, null: false, foreign_key: true
    add_reference :class_requests, :class_request_statuses, null: false, foreign_key: true
    add_reference :class_requests, :courses, null: false, foreign_key: true
  end
end
