require "test_helper"

class CourseTypeTest < ActiveSupport::TestCase
  def setup
    @course_type = course_types(:online_asynchronous)
  end

  test "should be valid with valid attributes" do
    assert @course_type.valid?
  end

  test "should have many courses" do
    assert_respond_to @course_type, :courses
  end

  test "should have correct name" do
    assert_equal "Online asíncrono", @course_type.name
  end

  test "should have correct description" do
    assert_equal "Cápsulas de videos, pruebas online", @course_type.description
  end

  test "should be able to access different course types" do
    assert_not_nil course_types(:online_synchronized)
    assert_not_nil course_types(:mixed)
    assert_not_nil course_types(:in_person)
  end
end
