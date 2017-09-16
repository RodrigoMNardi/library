class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :is_admin?

  def is_admin?
    if !logged_user? and !permitted_pages?
      redirect_to controller: 'books', action: 'index'
    end
  end

  def permitted_pages?
    puts params.inspect
    case params[:controller]
      when 'users'
        %w[create login].include? params[:action]
      when 'books'
        %w[index filtered].include? params[:action]
      else
        false
    end
  end
end
