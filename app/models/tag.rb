class Tag < ActiveRecord::Base
  has_many :assigned_tags
  has_many :questions

  attr_accessible :title, :description

end
