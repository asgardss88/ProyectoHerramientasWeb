class NotificationMailer < ActionMailer::Base
	default :from => "asgardss88@gmail.com"
  def answer_notification(user,question)
  	@user = user
  	@question = question
  	mail(:to => question.user.email, :subject => "answer to question")
  	
  end
end
