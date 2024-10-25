require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  def setup
    @material = materials(:material1)
  end

  test "should be valid with all attributes" do
    assert @material.valid?
  end

  test "should not be valid without name" do
    @material.name = nil
    assert_not @material.valid?
    assert_includes @material.errors[:name], "no puede estar en blanco"
  end

  test "should not be valid without description" do
    @material.description = nil
    assert_not @material.valid?
    assert_includes @material.errors[:description], "no puede estar en blanco"
  end

  test "should not be valid without course_id" do
    @material.course = nil
    assert_not @material.valid?
    assert_includes @material.errors[:course], "must exist"
  end

  test "should not be valid without material_type" do
    @material.material_type = nil
    assert_not @material.valid?
    assert_includes @material.errors[:material_type], "must exist"
  end

  test "should belong to a course" do
    assert_respond_to @material, :course
  end

  test "should belong to a material_type" do
    assert_respond_to @material, :material_type
  end
end
