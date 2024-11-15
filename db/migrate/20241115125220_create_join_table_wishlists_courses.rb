class CreateJoinTableWishlistsCourses < ActiveRecord::Migration[6.1]
  def change
    create_join_table :wishlists, :courses do |t|
      t.index [:wishlist_id, :course_id]
      t.index [:course_id, :wishlist_id]
    end
  end
end