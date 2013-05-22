class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :makecomment]
  before_filter :authenticate_user!, :only => [:index,:show,:new,:create,:destroy, :makecomment, :like,:unlike]
  before_filter :verify_user_vote, only: [:like, :unlike]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # GET /questions
  def index
    authorize! :list, Question, message: "You don't have permission to see the questions, please sign in"
    @questions = Question.includes(:user).all
  end

  # GET /questions/1
  def show
    authorize! :read, Question, message: "You don't have permission to see the questions, please sign in"
    @answers = @question.answers
  end

  # GET /questions/new
  def new
    authorize! :create, Question, message: "You don't have permission to make a question"
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    authorize! :create, Question, message: "You don't have permission to create a question"
    @question = Question.new(question_params)
    @question.votes=0
    @question.user_id = current_user.id 

    

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /questions/1
  def destroy
    authorize! :destroy, Question, message: "You don't have permission to delete a question"
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end
  
  #POST /questions/1/makecomment
  def makecomment
    authorize! :vote, Question, message: "You don't have permission to comment a question"

  end

  #PUT /questions/1/like
  def like

    @question.votes+=1
    if @question.save
      redirect_to @question, notice: "Vote saved successfully"
    else
      redirect_to @question, alert: "Error saving the vote"
    end

  end

  #PUT /questions/1/like
  def unlike
    @question.votes-=1
    if @question.save
      redirect_to @question, notice: "Vote saved successfully"
    else
      redirect_to @question, alert: "Error saving the vote"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params[:question]
    end

    def verify_user_vote
      authorize! :vote, Question, message: "You don't have permission to vote"
      @question = Question.find(params[:id])

      unless (@question.user_id==current_user.id)
        resp=@question.vote_questions.where("user_id = ?",current_user.id)

        if resp.empty?
          vote = VoteQuestion.new
          vote.user_id = current_user.id
          vote.question_id = @question.id
          vote.save
        
        else
          redirect_to @question, alert: "You can't vote twice for this question"
        end
      else
        redirect_to @question, alert: "You can't vote for your own question"
      end

    end
end
