class AddPointsRangeToEvaluationQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :evaluation_questions, :min_points, :integer
    add_column :evaluation_questions, :max_points, :integer
  end
end
