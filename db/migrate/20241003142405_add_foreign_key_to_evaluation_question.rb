class AddForeignKeyToEvaluationQuestion < ActiveRecord::Migration[7.0]
  def change
    unless foreign_key_exists?(:evaluation_questions, :evaluations)
      add_foreign_key(:evaluation_questions, :evaluations, column: :evaluation_id, on_delete: :cascade)
    end
  end
end