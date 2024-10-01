class CreateEvaluationQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluation_questions do |t|
      t.json  :content, null: false
      t.timestamps
    end
  end
end
