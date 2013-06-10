class QuestionCommentsController < ApplicationController
  before_action :set_question_comment, only: [:destroy]
  before_filter :authenticate_user!, :only =>[:new, :create, :destroy]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # GET /question_comments/new
  def new
    authorize! :create, QuestionComment , message: "You don't have permission to comment this question"
    @question_comment = QuestionComment.new
    @question_id = params[:question_id]
  end


  # POST /question_comments
  def create
    authorize! :create, QuestionComment , message: "You don't have permission to comment this question"
    @question_comment = QuestionComment.new(question_comment_params)
    @question_comment.user_id = current_user.id
    @question_comment.question_id = params[:question_id]
    if @question_comment.save
      NotificationMailer.comment_question_notification(current_user,@question_comment.question).deliver
      redirect_to question_url(params[:question_id]), notice: 'Question comment was successfully created.'
    else
      render action: 'new'
    end
  end

  # DELETE /question_comments/1
  def destroy
    authorize! :create, QuestionComment , message: "You don't have permission to destroy comments"
    @question_comment.destroy
    redirect_to question_comments_url, notice: 'Question comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_comment
      @question_comment = QuestionComment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_comment_params
      params[:question_comment]
    end
end
