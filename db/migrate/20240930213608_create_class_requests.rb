class CreateClassRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :class_requests do |t|
      t.string :description, null: false
      t.date :startDate, null: false
      t.date :endaDate, null: false

      t.timestamps
    end
  end
end
