class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :vote_answers, dependent: :destroy
  has_many :vote_questions, dependent: :destroy
  has_many :voted_answers, :dependent => :destroy, :class_name => "Answer", :through => :vote_answers, :source => :answer
  has_many :voted_questions, :dependent => :destroy, :class_name => "Question", :through => :vote_questions, :source => :user
  has_many :answer_comments, dependent: :destroy
  has_many :question_comments, dependent: :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :admin, :points
end
