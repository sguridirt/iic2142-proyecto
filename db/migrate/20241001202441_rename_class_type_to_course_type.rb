class RenameClassTypeToCourseType < ActiveRecord::Migration[7.0]
  def change
    rename_table :class_types, :course_types
  end
end
