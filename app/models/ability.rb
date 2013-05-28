class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin
        can [:list,:read,:update,:destroy], User
        can [:list,:read, :destroy], Question
        can [:read,:destroy], AnswerComment 
        can [:read,:destroy], QuestionComment 
    else
        can [:read, :update], User
        can [:list,:create,:read,:comment,:vote], Question
        can [:read,:create,:comment,:vote,:validate], Answer
        can [:read,:create,], AnswerComment 
        can [:read,:create], QuestionComment 
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
