class CreateEvaluationFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluation_feedbacks do |t|
      t.text :content, null: false
      t.references :evaluation, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.timestamps
    end
  end
end
