require "test_helper"

class TeacherReviewTest < ActiveSupport::TestCase
  def setup
    @teacher_review = teacher_reviews(:teacher_review1) # Usa el fixture de teacher_reviews
  end

  test "should be valid" do
    assert @teacher_review.valid?
  end

  test "should belong to a teacher" do
    assert_not_nil @teacher_review.teacher
    assert_equal teachers(:teacher), @teacher_review.teacher
  end


  test "rating should be present" do
    @teacher_review.rating = nil
    assert_not @teacher_review.valid?
  end

  test "rating should be an integer between 1 and 5" do
    @teacher_review.rating = 6
    assert_not @teacher_review.valid?

    @teacher_review.rating = 0
    assert_not @teacher_review.valid?

    @teacher_review.rating = 3
    assert @teacher_review.valid?
  end

  test "comment should be optional" do
    @teacher_review.comment = nil
    assert @teacher_review.valid?
  end



end
