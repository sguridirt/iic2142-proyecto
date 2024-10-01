class RenameCamelCaseColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :evaluations, :startDate, :start_date

    rename_column :class_requests, :startDate, :start_date
    rename_column :class_requests, :endaDate, :end_date # Typo in the original column name

    rename_column :enrollments, :enrollmentDate, :enrollment_date

    rename_column :users, :profilePictureURL, :profile_picture_url
  end
end
