require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin_user)
    @teacher = users(:teacher_user)
    @student = users(:student_user)
  end

  test "valid user" do
    assert @admin.valid?
    assert @teacher.valid?
    assert @student.valid?
  end

  test "should require name" do
    user = User.new(
      email: "test@example.com",
      password: "password123",
      user_role: user_roles(:admin)
    )
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "should require email" do
    @admin.email = nil
    assert_not @admin.valid?
    assert_includes @admin.errors[:email], "can't be blank"
  end

  test "should require valid email format" do
    @admin.email = "invalid_email"
    assert_not @admin.valid?
    assert_includes @admin.errors[:email], "is invalid"
  end

  test "should require unique email" do
    duplicate_user = @admin.dup
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should require user_role" do
    @admin.user_role = nil
    assert_not @admin.valid?
    assert_includes @admin.errors[:user_role], "must exist"
  end

  test "should have correct role associations" do
    assert_equal "Admin", @admin.user_role.name
    assert_equal "Teacher", @teacher.user_role.name
    assert_equal "Student", @student.user_role.name
  end

  test "password should have minimum length" do
    @admin.password = "12345"
    assert_not @admin.valid?
    assert_includes @admin.errors[:password], "is too short (minimum is 6 characters)"
  end

  test "should accept valid profile picture" do
    @admin.profile_picture_url = "avatar.jpg"
    assert @admin.valid?
  end

  test "should validate phone format and presence" do
    @admin.phone = "invalid_phone"
    assert_not @admin.valid?
    assert_includes @admin.errors[:phone], "is invalid"
    
    @admin.phone = nil
    assert_not @admin.valid?
    assert_includes @admin.errors[:phone], "can't be blank"
  end

  test "should require unique phone" do
    duplicate_user = @admin.dup
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:phone], "has already been taken"
  end

  test "should create associated student record" do
    new_user = User.create(
      name: "New Student",
      email: "new_student@test.com",
      password: "password123",
      phone: "+56900000004",
      user_role: user_roles(:student)
    )
    assert new_user.student.present?
  end

  test "should create associated teacher record" do
    new_user = User.create(
      name: "New Teacher",
      email: "new_teacher@test.com",
      password: "password123",
      phone: "+56900000005",
      user_role: user_roles(:teacher)
    )
    assert new_user.teacher.present?
  end

  test "role check methods" do
    assert @teacher.teacher?
    assert @student.student?
    assert @admin.admin?
    
    assert_not @teacher.student?
    assert_not @teacher.admin?
    assert_not @student.teacher?
    assert_not @student.admin?
    assert_not @admin.teacher?
    assert_not @admin.student?
  end
  
  test "should handle avatar attachment and thumbnail" do
    @admin.save
    @admin.avatar.attach(
      io: File.open(Rails.root.join('test/fixtures/files/avatar.jpg')),
      filename: 'avatar.jpg',
      content_type: 'image/jpeg'
    )
    assert @admin.avatar.attached?
    assert_not_nil @admin.avatar_thumbnail
end

  

end




