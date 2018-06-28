class ApplicationController < ActionController::Base
  # prevent cross-site forgery attacks
  protect_from_forgery with: :null_session
end
