class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.date :startDate, null: false
      t.date :endDate, null: false

      t.timestamps
    end
  end
end
