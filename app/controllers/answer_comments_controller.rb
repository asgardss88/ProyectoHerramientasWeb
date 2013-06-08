class AnswerCommentsController < ApplicationController
  before_action :set_answer_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only =>[:new, :create, :destroy]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # GET /answer_comments/new
  def new
    authorize! :create, AnswerComment , message: "You don't have permission to comment this answer"

    @answer_id = params[:answer_id]
    @question_id = params[:question_id]
    @answer_comment = AnswerComment.new
  end

  # POST /answer_comments
  def create
    authorize! :create, AnswerComment , message: "You don't have permission to comment this question"
    @answer_comment = AnswerComment.new(answer_comment_params)

    
    @answer_comment.user_id = current_user.id
    @answer_comment.answer_id = params[:answer_id]

    if @answer_comment.save
      redirect_to question_path(params[:question_id]), notice: 'Answer comment was successfully created.'
    else
      render action: 'new'
    end
  end


  # DELETE /answer_comments/1
  def destroy
    authorize! :create, AnswerComment , message: "You don't have permission to destroy comments"
    @answer_comment.destroy
    redirect_to answer_comments_url, notice: 'Answer comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_comment
      @answer_comment = AnswerComment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def answer_comment_params
      params[:answer_comment]
    end
end
