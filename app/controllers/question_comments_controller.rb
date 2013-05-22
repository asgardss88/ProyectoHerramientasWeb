class QuestionCommentsController < ApplicationController
  before_action :set_question_comment, only: [:show, :edit, :update, :destroy]

  # GET /question_comments
  def index
    @question_comments = QuestionComment.all
  end

  # GET /question_comments/1
  def show
  end

  # GET /question_comments/new
  def new
    @question_comment = QuestionComment.new
  end

  # GET /question_comments/1/edit
  def edit
  end

  # POST /question_comments
  def create
    @question_comment = QuestionComment.new(question_comment_params)

    if @question_comment.save
      redirect_to @question_comment, notice: 'Question comment was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /question_comments/1
  def update
    if @question_comment.update(question_comment_params)
      redirect_to @question_comment, notice: 'Question comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /question_comments/1
  def destroy
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
