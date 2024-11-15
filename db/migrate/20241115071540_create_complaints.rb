class CreateComplaints < ActiveRecord::Migration[7.0]
  def change
    create_table :complaints do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end

