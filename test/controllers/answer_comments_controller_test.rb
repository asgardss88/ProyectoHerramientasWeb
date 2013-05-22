require 'test_helper'

class AnswerCommentsControllerTest < ActionController::TestCase
  setup do
    @answer_comment = answer_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answer_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answer_comment" do
    assert_difference('AnswerComment.count') do
      post :create, answer_comment: {  }
    end

    assert_redirected_to answer_comment_path(assigns(:answer_comment))
  end

  test "should show answer_comment" do
    get :show, id: @answer_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @answer_comment
    assert_response :success
  end

  test "should update answer_comment" do
    patch :update, id: @answer_comment, answer_comment: {  }
    assert_redirected_to answer_comment_path(assigns(:answer_comment))
  end

  test "should destroy answer_comment" do
    assert_difference('AnswerComment.count', -1) do
      delete :destroy, id: @answer_comment
    end

    assert_redirected_to answer_comments_path
  end
end
