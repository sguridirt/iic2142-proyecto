class AddCascadeDeleteToCoursesForTeachers < ActiveRecord::Migration[7.0]
  def change
    # Eliminar la clave foránea existente entre courses y teachers
    remove_foreign_key :courses, :teachers

    # Volver a agregar la clave foránea con la opción de eliminar en cascada
    add_foreign_key :courses, :teachers, on_delete: :cascade
  end
end
