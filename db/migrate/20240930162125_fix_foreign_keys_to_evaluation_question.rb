class FixForeignKeysToEvaluationQuestion < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :evaluation_questions, :evaluations
    add_foreign_key :evaluation_questions, :evaluations, null: false, on_delete: :cascade

  end
end
