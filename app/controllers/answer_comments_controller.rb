class AnswerCommentsController < ApplicationController
  before_action :set_answer_comment, only: [:show, :edit, :update, :destroy]

  # GET /answer_comments
  def index
    @answer_comments = AnswerComment.all
  end

  # GET /answer_comments/1
  def show
  end

  # GET /answer_comments/new
  def new
    @answer_comment = AnswerComment.new
  end

  # GET /answer_comments/1/edit
  def edit
  end

  # POST /answer_comments
  def create
    @answer_comment = AnswerComment.new(answer_comment_params)

    if @answer_comment.save
      redirect_to @answer_comment, notice: 'Answer comment was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /answer_comments/1
  def update
    if @answer_comment.update(answer_comment_params)
      redirect_to @answer_comment, notice: 'Answer comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /answer_comments/1
  def destroy
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
