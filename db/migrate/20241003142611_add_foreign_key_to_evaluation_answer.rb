class AddForeignKeyToEvaluationAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :evaluation_answers, :evaluation_question, foreign_key: { on_delete: :cascade }
    add_reference :evaluation_answers, :student, foreign_key: true
  end
end