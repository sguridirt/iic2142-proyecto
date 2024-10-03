class AddForeignKeyToEvaluation < ActiveRecord::Migration[7.0]
  def change
    add_column :evaluations, :course_id, :integer
    add_foreign_key :evaluations, :courses, column: :course_id, on_delete: :cascade
    add_reference :evaluations, :evaluation_type, foreign_key: true
  end
end