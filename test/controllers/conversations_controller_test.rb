require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @conversation = conversations(:conversation1)
    @user = users(:teacher_user)
    @another_user = users(:student_user)
    sign_in @user
  end

  test "should get index" do
    get conversations_url
    assert_response :success
    assert_not_nil assigns(:conversations)
  end

  test "should get new" do
    get new_conversation_url
    assert_response :success
  end

  test "should create conversation" do
    assert_difference('Conversation.count') do
      post conversations_url, params: { conversation: { title: 'New Conversation', user_ids: [@another_user.id] } }
    end

    assert_redirected_to conversation_url(Conversation.last)
  end

  test "should show conversation" do
    get conversation_url(@conversation)
    assert_response :success
  end

  test "should destroy conversation" do
    assert_difference('Conversation.count', -1) do
      delete conversation_url(@conversation)
    end

    assert_redirected_to conversations_url
  end
end