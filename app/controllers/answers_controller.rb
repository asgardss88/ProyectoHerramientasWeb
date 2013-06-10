class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_filter :set_question, only: [:new, :create, :makecomment]
  before_filter :authenticate_user!, only: [:new,:create]
  before_filter :can_validate, only: [:validate]
  before_filter :verify_user_vote, only: [:like, :unlike]

   rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end


  # GET /answers/new
  def new
    authorize! :create, Answer, message: "You don't have permission to answer questions"
    unless current_user.id == @question.user_id
      @answer = Answer.new
      @answer.question_id=@question.id
    else
      redirect_to question, alert: "You can't answer your own question"
    end
  end


  # POST /answers
  def create
    authorize! :create, Answer, message: "You don't have permission to answer questions"
    @answer = Answer.new(answer_params)
    @answer.state=false
    @answer.votes=0
    @answer.question_id = params[:question_id]
    @answer.user_id=current_user.id

    if @answer.save
      NotificationMailer.answer_notification(current_user,Question.find(params[:question_id])).deliver
      redirect_to question_url(params[:question_id]), notice: 'Answer was successfully created.'
    else
      render action: 'new'
    end
  end


  #POST /answers/1/makecomment
  def makecomment

  end

  #PUT /answers/1/like
  def like
    @answer.votes+=1
    if @answer.save
      NotificationMailer.vote_answer_notification(@answer).deliver
      redirect_to @answer.question, notice: "Vote saved successfully"
    else
      redirect_to @answer.question, alert: "Error saving the vote"
    end
  end

  #PUT /answers/1/like
  def unlike
    @answer.votes-=1
    
    if @answer.save
      NotificationMailer.vote_answer_notification(@answer).deliver
      redirect_to @answer.question, notice: "Vote saved successfully"
    else
      redirect_to @answer.question, alert: "Error saving the vote"
    end
  end

 #PUT /answers/1/validate
  def validate

    answer=Answer.find(params[:id])
    unless answer.state
      user=answer.user
      user.points+=1+@question.bonus
      user.save
      answer.state=true
      answer.save

      NotificationMailer.validate_answer_notification(current_user,user,@question).deliver

      redirect_to @question, notice: "Validated successfully"
    else
      redirect_to @question, alert: "You can't valide an answer twice"
    end


    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def answer_params
      params[:answer]
    end

    def set_question
      @question=Question.find(params[:question_id])
    end

    def can_validate
      authorize! :validate, Answer, message: "You don't have permission to validate this answer"
      @question=Question.find(params[:question_id])
      
      unless @question.user_id == current_user.id
        redirect_to root_url, alert: "You can't validate this answer"
      end

    end

    def verify_user_vote
      authorize! :vote, Answer, message: "You don't have permission to vote for this answer"
      @answer = Answer.find(params[:id])

      unless (@answer.user_id==current_user.id)
        resp=@answer.vote_answers.where("user_id = ?",current_user.id)

        if resp.empty?
          vote = VoteAnswer.new
          vote.user_id = current_user.id
          vote.answer_id = @answer.id
          vote.save
        
        else
          redirect_to question_url(@answer.question_id), alert: "You can't vote twice for this answer"
        end
      else
        redirect_to question_url(@answer.question_id), alert: "You can't vote for your own answer"
      end

    end
end
