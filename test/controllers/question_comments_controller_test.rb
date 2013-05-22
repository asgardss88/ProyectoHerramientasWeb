require 'test_helper'

class QuestionCommentsControllerTest < ActionController::TestCase
  setup do
    @question_comment = question_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_comment" do
    assert_difference('QuestionComment.count') do
      post :create, question_comment: {  }
    end

    assert_redirected_to question_comment_path(assigns(:question_comment))
  end

  test "should show question_comment" do
    get :show, id: @question_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_comment
    assert_response :success
  end

  test "should update question_comment" do
    patch :update, id: @question_comment, question_comment: {  }
    assert_redirected_to question_comment_path(assigns(:question_comment))
  end

  test "should destroy question_comment" do
    assert_difference('QuestionComment.count', -1) do
      delete :destroy, id: @question_comment
    end

    assert_redirected_to question_comments_path
  end
end
