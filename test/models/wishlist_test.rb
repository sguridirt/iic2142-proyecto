require "test_helper"

class WishlistTest < ActiveSupport::TestCase
  def setup
    @student = users(:student_user).student
    @course1 = courses(:maths_101)
    @course2 = courses(:maths_201)
    @wishlist = Wishlist.create(student: @student)
  end

  test "should be valid with a student" do
    assert @wishlist.valid?
  end

  test "should not be valid without a student" do
    @wishlist.student = nil
    assert_not @wishlist.valid?
  end

  test "should be able to add courses" do
    @wishlist.courses << @course1
    @wishlist.courses << @course2
    assert_equal 2, @wishlist.courses.count
  end

  test "should be able to remove courses" do
    @wishlist.courses << @course1
    @wishlist.courses.delete(@course1)
    assert_equal 0, @wishlist.courses.count
  end
end
