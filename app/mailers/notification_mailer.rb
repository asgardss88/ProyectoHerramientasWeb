class NotificationMailer < ActionMailer::Base
	default :from => "asgardss88@gmail.com", only: [:answer_notification, :validate_answer_notification, :vote_question_notification, :vote_question_notification, :comment_question_notification]


   def validate_answer_notification(user,owner,question)
  	@user = user
  	@owner = owner
  	@question = question
  	mail(:to => owner.email, :subject => "your answer was accepted")
  end

  def answer_notification(user,question)
  	@user = user
  	@question = question
  	mail(:to => question.user.email, :subject => "answer to question")
  	
  end

  def vote_answer_notification(answer)
  	@answer=answer
  	mail(:to => answer.user.email, :subject => "someone vote for your answer")

  end
 
  def vote_question_notification(question)
  	@question = question
  	mail(:to => question.user.email, :subject => "someone vote for your question")
  end

  def comment_question_notification(user, question)
  	@user = user
  	@question = question
  	mail(:to => question.user.email, :subject => "comment to your question")
  end


end
