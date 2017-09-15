module ApplicationHelper
  def logged_user?
    session.has_key? :user and (!session[:user].nil? and !session[:user].empty?)
  end
end
