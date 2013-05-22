class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  belongs_to :question
  has_many :answer_comments, :dependent => :destroy
end
