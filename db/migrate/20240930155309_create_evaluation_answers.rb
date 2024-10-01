  class CreateEvaluationAnswers < ActiveRecord::Migration[7.0]
    def change
      create_table :evaluation_answers do |t|
        t.string :content, null: false
        t.integer :points, null: false
        t.integer :status, null: false
        t.timestamps
      end
    end
  end
