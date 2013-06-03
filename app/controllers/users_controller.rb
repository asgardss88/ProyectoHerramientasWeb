class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index,:show,:edit,:destroy,:update]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # GET /users
  def index
    authorize! :list, User, message: "You don't have permission to do this action"
    @users = User.all
  end

  # GET /users/1
  def show
    authorize! :read, User, message: "You don't have permission to see user information"
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize! :update, User, message: "You don't have permission to do this action"
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to questions_path, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize! :update, User, message: "You don't have permission to do this action"

    #if !current_user.admin and current_user.id != user_params[:id]
     #  redirect_to questions_path, alert: "You don̈́'t have permission to edit other user"
    #end 

    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def notification
    user=current_user

    @notificaciones1=[]
    c=Question.includes(:answers).where("created_at >= ?",user.last_sign_in_at)
    question_list=c.where("user_id = ?", user.id)

    question_list.each  do |qst|

      @notificaciones1.concat(qst.answers)

    end

    @notificaciones2=[]
    c=Question.includes(:question_comments).where("created_at >= ?",user.last_sign_in_at)
    question_list=c.where("user_id = ?", user.id)

    question_list.each do |qst|

	@notificaciones2.concat(qst.question_comments)

    end

    @notificaciones3=[]
    c=Question.includes(:vote_questions).where("created_at >= ?",user.last_sign_in_at)
    question_list=c.where("user_id = ?", user.id)

    question_list.each do |qst|

	@notificaciones3.concat(qst.vote_questions)

    end

    @notificaciones4=[]
    c=Question.includes(:question_comments).where("created_at >= ?",user.last_sign_in_at)
    question_list=c.where("user_id = ?", user.id)

    question_list.each do |qst|

	@notificaciones4.concat(qst.vote_questions)

    end


  end

  # DELETE /users/1
  def destroy
    authorize! :destroy, User, message: "You dont have permission to do this action"
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params[:user]
    end
end
