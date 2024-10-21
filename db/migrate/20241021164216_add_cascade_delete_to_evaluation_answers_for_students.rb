class AddCascadeDeleteToEvaluationAnswersForStudents < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :evaluation_answers, :students
    add_foreign_key :evaluation_answers, :students, on_delete: :cascade
  end
end

