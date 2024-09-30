class CreateEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluations do |t|
      t.string :name, null: false
      t.date :startDate, null: false
      t.integer :duration, null: false
      t.timestamps
    end
  end
end
