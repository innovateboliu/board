class Course < ActiveRecord::Base
  attr_accessible :description, :id, :name
  has_many :topics
end
