class AddCascadeDeleteToMaterialsForCourses < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :materials, :courses
    add_foreign_key :materials, :courses, on_delete: :cascade
  end
end

