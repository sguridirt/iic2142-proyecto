class CreateTeacherReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :teacher_reviews do |t|
      t.string :title, null: false
      t.string :comment, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
