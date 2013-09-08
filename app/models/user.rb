class User < ActiveRecord::Base
  attr_accessible :password, :email, :password_confirmation, :username
  acts_as_authentic do |configuration| 
      configuration.session_class = Session
  end
end
