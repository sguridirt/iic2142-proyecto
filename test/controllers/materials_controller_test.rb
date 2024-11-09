require "test_helper"

class MaterialsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @material = materials(:material1)
    @course = @material.course
    @user = users(:teacher_user)
    sign_in @user
  end

  test "should log error when material upload fails" do
    assert_no_difference('Material.count') do
      post process_upload_course_materials_path(@course), params: {
        material: {
          name: "", # Invalid empty name to trigger error
          description: "Test description",
          material_type: "document"
        }
      }
    end
    assert_template :upload
  end

  test "should show material" do
    get material_path(@material)
    assert_response :success
  end

  test "should get upload form" do
    get upload_course_materials_path(@course)
    assert_response :success
  end

  test "should create material" do
    assert_difference('Material.count') do
      post course_materials_path(@course), params: {
        material: {
          name: "New Test Material",
          description: "Test Description",
          material_type_id: @material.material_type_id
        }
      }
    end
    assert_redirected_to course_path(@course)
    assert_equal 'Material subido exitosamente.', flash[:notice]
  end

  test "should not create material with invalid params" do
    assert_no_difference('Material.count') do
      post course_materials_path(@course), params: {
        material: {
          name: "",
          description: "",
          material_type_id: nil
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should destroy material" do
    assert_difference('Material.count', -1) do
      delete material_path(@material)
    end
    assert_redirected_to course_path(@material.course)
    assert_equal 'Material eliminado exitosamente.', flash[:notice]
  end

  test "should process upload successfully" do
    assert_difference('Material.count') do
      post process_upload_course_materials_path(@course), params: {
        material: {
          name: "Uploaded Material",
          description: "Uploaded Description",
          material_type_id: @material.material_type_id
        }
      }
    end
    assert_redirected_to course_path(@course)
    assert_equal 'Material subido exitosamente.', flash[:notice]
  end
end