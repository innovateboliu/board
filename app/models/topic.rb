class Topic < ActiveRecord::Base
  attr_accessible :content, :course_id, :id, :title, :user_id
  has_many :comments
  belongs_to :course
  belongs_to :user
end
