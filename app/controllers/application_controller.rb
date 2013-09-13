class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :existing_user

  def existing_user
    if defined?(@existing_user)
      @existing_user 
    else
      session = Session.find
      if session.nil?
        nil
      else
        session.record
      end
    end
  end

  def existing_session
    Session.find
  end
end
