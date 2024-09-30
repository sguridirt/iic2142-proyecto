class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.date :enrollmentDate, null: false

      t.timestamps
    end
  end
end
