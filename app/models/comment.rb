class Comment < ActiveRecord::Base
  attr_accessible :body, :id, :topic_id, :user_id, :votes
  belongs_to :user
  belongs_to :topic

  after_initialize :default_values

  def default_values
      self.votes ||= 0
  end
end
