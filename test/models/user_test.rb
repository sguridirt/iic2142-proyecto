require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user_role = UserRole.create!(name: 'Student', description: 'Student Role')
    @user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123",
      name: "Test User",
      phone: "+56912345678",
      user_role: @user_role
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should require email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should require valid email format" do
    @user.email = "invalid_email"
    assert_not @user.valid?
    assert_includes @user.errors[:email], "is invalid"
  end

  test "should require unique email" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should require phone" do
    @user.phone = nil
    assert_not @user.valid?
    assert_includes @user.errors[:phone], "can't be blank"
  end

  test "should require valid phone format" do
    @user.phone = "invalid_phone"
    assert_not @user.valid?
    assert_includes @user.errors[:phone], "is invalid"
  end

  test "should require unique phone" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should belong to user_role" do
    assert_respond_to @user, :user_role
  end

  test "should have one student" do
    assert_respond_to @user, :student
  end

  test "should have one teacher" do
    assert_respond_to @user, :teacher
  end

  test "should have one admin" do
    assert_respond_to @user, :admin
  end

  test "should have many conversation_participants" do
    assert_respond_to @user, :conversation_participants
  end

  test "should have many conversations" do
    assert_respond_to @user, :conversations
  end

  test "should have many messages" do
    assert_respond_to @user, :messages
  end

  test "should create student after create when role is Student" do
    @user.save
    assert @user.student.present?
  end

  test "should create teacher after create when role is Teacher" do
    @user.user_role = UserRole.create!(name: 'Teacher', description: 'Teacher Role')
    @user.save
    assert @user.teacher.present?
  end

  test "should be teacher?" do
    @user.user_role = UserRole.create!(name: 'Teacher', description: 'Teacher Role')
    assert @user.teacher?
  end

  test "should be student?" do
    assert @user.student?
  end

  test "should be admin?" do
    @user.user_role = UserRole.create!(name: 'Admin', description: 'Admin Role')
    assert @user.admin?
  end

  test "should handle avatar attachment and thumbnail" do
    @user.save
    @user.avatar.attach(
      io: File.open(Rails.root.join('test/fixtures/files/avatar.jpg')),
      filename: 'avatar.jpg',
      content_type: 'image/jpeg'
    )
    assert @user.avatar.attached?
    assert_not_nil @user.avatar_thumbnail
  end

  

  test "should validate password presence" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "should validate password confirmation" do
    @user.password_confirmation = "different"
    assert_not @user.valid?
  end

  test "should validate password length" do
    @user.password = @user.password_confirmation = "short"
    assert_not @user.valid?
  end

  test "should handle user deletion" do
    @user.save
    assert @user.destroy
  end

  test "should handle user update" do
    @user.save
    assert @user.update(name: "Updated Name")
  end

  test "should validate case insensitive email uniqueness" do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "should validate case insensitive phone uniqueness" do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.phone = @user.phone.upcase
    assert_not duplicate_user.valid?
  end
end
