class ChangeContentTypeInEvaluationQuestions < ActiveRecord::Migration[6.0]
  def change
    change_column :evaluation_questions, :content, :text
  end
end
