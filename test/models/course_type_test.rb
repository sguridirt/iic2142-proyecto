require "test_helper"

class CourseTypeTest < ActiveSupport::TestCase
  def setup
    @course_type = CourseType.new(
      name: "Online",
      description: "Virtual learning environment"
    )
  end

  test "should be valid with valid attributes" do
    assert @course_type.valid?
  end

  test "should have many courses" do
    assert_respond_to @course_type, :courses
  end
end
