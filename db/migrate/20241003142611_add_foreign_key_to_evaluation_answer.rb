class AddForeignKeyToEvaluationAnswer < ActiveRecord::Migration[7.0]
  def change
    # add_column :evaluation_answers, :evaluation_question_id, :integer
    # add_foreign_key :evaluation_answers, :evaluation_questions, column: :evaluation_question_id, on_delete: :cascade

    # add_reference :evaluation_answers, :student, foreign_key: true
  end
end