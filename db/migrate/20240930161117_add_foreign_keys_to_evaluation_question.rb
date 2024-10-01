class AddForeignKeysToEvaluationQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :evaluation_questions, :evaluation, null: false, foreign_key: true
  end
end
