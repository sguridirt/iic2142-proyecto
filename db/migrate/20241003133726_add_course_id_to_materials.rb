class AddCourseIdToMaterials < ActiveRecord::Migration[7.0]
  def change
    add_reference :materials, :course, null: false, foreign_key: true, on_delete: :cascade
  end
end
