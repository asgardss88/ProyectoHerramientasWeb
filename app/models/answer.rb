class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  belongs_to :question
  has_many :answer_comments, :dependent => :destroy
  has_many :vote_answers
  has_many :voters, :class_name=>"User", :through => :vote_answers, :source => :answer
end
