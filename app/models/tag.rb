class Tag < ActiveRecord::Base
  has_many :assigned_tags
  has_many :questions, :through => :assigned_tags

  attr_accessible :title, :description

end
