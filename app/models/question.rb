class Question < ActiveRecord::Base

  attr_accessible :ask_for,:description, :tag_id

  validates :ask_for, :presence => true,
  						:length => {:minimum=> 5}
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :assigned_tags, :dependent => :destroy
  has_many :question_comments, :dependent => :destroy
  belongs_to  :tag
  has_many :vote_questions
  has_many :voters, :class_name => "Question", :through => :vote_questions, :source => :question
  
end
