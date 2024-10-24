require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  def setup
    @teacher_user = User.create!(
      email: "teacher@test.com",
      name: "Test Teacher",
      phone: "+56900000002",
      password: "password",
      password_confirmation: "password",
      user_role_id: UserRole.find_or_create_by(name: 'Teacher').id
    )
    
    @teacher = Teacher.create!(user_id: @teacher_user.id)

    @course_type = CourseType.create!(
      name: "Programming",
      description: "Programming courses"
    )

    @course = Course.create!(
      title: "Ruby Course",
      description: "Learn Ruby Programming",
      teacher_id: @teacher.id,
      course_type: @course_type,
      start_date: Date.today,
      end_date: Date.today + 30.days
    )
    
    @material_type = MaterialType.create!(
      name: "Video",
      description: "Video material"
    )
    
    @valid_material = Material.new(
      name: "Ruby Basics",
      description: "Introduction to Ruby programming",
      course: @course,
      material_type: @material_type
    )
  end

  test "should be valid with all attributes" do
    assert @valid_material.valid?
  end

  test "should not be valid without name" do
    @valid_material.name = nil
    assert_not @valid_material.valid?
    assert_includes @valid_material.errors[:name], "can't be blank"
  end

  test "should not be valid without description" do
    @valid_material.description = nil
    assert_not @valid_material.valid?
    assert_includes @valid_material.errors[:description], "can't be blank"
  end

  test "should not be valid without course_id" do
    @valid_material.course = nil
    assert_not @valid_material.valid?
    assert_includes @valid_material.errors[:course_id], "can't be blank"
  end

  test "should not be valid without material_type" do
    @valid_material.material_type = nil
    assert_not @valid_material.valid?
    assert_includes @valid_material.errors[:material_type], "can't be blank"
  end

  test "should belong to a course" do
    assert_respond_to @valid_material, :course
  end

  test "should belong to a material_type" do
    assert_respond_to @valid_material, :material_type
  end
end
