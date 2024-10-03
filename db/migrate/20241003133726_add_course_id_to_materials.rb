class AddCourseIdToMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :materials, :course_id, :integer
    add_foreign_key :materials, :courses, column: :course_id
    add_index :materials, :course_id
  end
end
