class AddForeignKeysToMaterial < ActiveRecord::Migration[7.0]
  def change
    add_reference :materials, :material_types, null: false, foreign_key: true
  end
end
