class CreateClassRequestStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :class_request_statuses do |t|
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
