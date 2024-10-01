class FixCourseDatesColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :courses, :startDate, :start_date
    rename_column :courses, :endDate, :end_date
  end
end
