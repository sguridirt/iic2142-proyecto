class AddForeignKeysToCourse < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :teachers, null: false, foreign_key: true
    add_reference :courses, :class_types, null: false, foreign_key: true
  end
end
