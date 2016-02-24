class ApplicationController < ActionController::Base
  # LOGO = 'UNLV'
  APP_NAME = 'Scavenger Hunt'

  protect_from_forgery with: :exception

  helper_method :logo, :app_name
  before_action :install, :current_user, :current_task, :authorize

  def install
    if User.admins.empty?
      # create an admin account
      flash[:danger] = 'Please create an initial admin account'
      redirect_to new_user_form_path
    end
  end

  def current_task
    @current_task = Task.current_task(controller_name, action_name, request.method)
  end

  def current_user
    @current_user = User.current_user(session)
  end

  def authorize
    unless @current_user.authorized? @current_task and @current_user.permitted? request.path
      case request.path
        when /\/event\/[0-9]+/, /\/join\/[0-9]+/, /\/visit\/\w+/
          flash[:danger] = 'You must be logged in'
          redirect_to login_form_path(redirect_to: request.path)
        when /\/user\/([0-9]+)/
          flash[:danger] = 'You are not authorized to access that page!'
          redirect_to show_user_path(@current_user)
        else
          flash[:danger] = 'You are not authorized to access that page!'
          redirect_to @current_user.guest? ? root_path : show_user_path(@current_user)
      end
    end
  end

  # def logo
  #   return LOGO
  # end

  def app_name
    return APP_NAME
  end

  def login(user)
    reset_session
    session[:user_id] = user.id
  end

  def logout
    reset_session
    redirect_to root_url
  end
end
