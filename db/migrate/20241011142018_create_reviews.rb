class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true, null: false
      t.integer :rating
      t.text :content
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
