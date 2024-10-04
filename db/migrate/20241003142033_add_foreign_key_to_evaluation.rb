class AddForeignKeyToEvaluation < ActiveRecord::Migration[7.0]
  def change
    add_reference :evaluations, :course, foreign_key: { on_delete: :cascade }
    add_reference :evaluations, :evaluation_type, foreign_key: true
  end
end