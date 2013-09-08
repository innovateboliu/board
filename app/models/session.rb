class Session < Authlogic::Session::Base
  # attr_accessible :title, :body
    authenticate_with User
end
