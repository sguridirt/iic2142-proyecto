require "test_helper"

class TeacherTest < ActiveSupport::TestCase
  def setup
    @user = users(:teacher_user)
    @teacher = teachers(:teacher)
  end

  test "should be valid with a user" do
    assert @teacher.valid?
  end

  test "should not be valid without a user" do
    @teacher.user = nil
    assert_not @teacher.valid?
  end

  test "should have a user_name method that returns the user's name" do
    assert_equal @user.name, @teacher.user_name
  end

  test "should destroy associated courses" do
    assert_difference('Course.count', -@teacher.courses.count) do
      @teacher.destroy
    end
  end

  test "should destroy associated teacher_reviews" do
    assert_difference('TeacherReview.count', -@teacher.teacher_reviews.count) do
      @teacher.destroy
    end
  end

  test "should destroy associated evaluation_feedbacks" do
    assert_difference('EvaluationFeedback.count', -@teacher.evaluation_feedbacks.count) do
      @teacher.destroy
    end
  end
end
