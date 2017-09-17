class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_permission

  # Nesse método fazemos algumas validações para evitar que usuários não logados acessem certas páginas
  # Quando o método logged_user? for verdadeiro, assinala que ele é um administrador na versão atual e
  # tem poderes para acessar as páginas que são permitidas. Caso contrário será redicionado a página
  # 'root' onde todos tem permissão
  def check_permission
    if !logged_user? and !permitted_pages?
      redirect_to controller: 'books', action: 'index'
    end
  end

  # Valida quais controller e actions podem ser acessadas pelos usuários, fazendo uma politica de acesso
  # através do controller e action.
  def permitted_pages?
    case params[:controller]
      when 'users'
        %w[create login].include? params[:action]
      when 'books'
        %w[index filtered sortby].include? params[:action]
      else
        false
    end
  end
end
