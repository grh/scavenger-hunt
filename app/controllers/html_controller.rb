class HtmlController < ApplicationController
=begin
= DEVELOPER

= HTML CONTROLLER

  The HtmlController contains all the actions that are intended to render actual HTML. This is a departure from the normal
  separation of concerns encountered in a Rails app, but the administrators found this organization to be just as useful.

  If an action is intended to render HTML, then it should be included in this controller. For example, the new_user_form action
  renders an HTML form to create a new account. The actual creation of the user object and persistence to the database
  is handled via the normal user controller.

=end
  
  skip_before_action :install, only: :new_user_form
  ##################
  # PUBLIC ACTIONS #
  ##################

  def home
    @current_events = Event.current
    @upcoming_events = Event.upcoming
  end

  def about_doc
  end

  def user_doc
  end

  def developer_doc
  end

  def new_user_form
    @user = User.new
  end

  def login_form
  end

  def visit_location_form
    @location = Location.find_by_tag(params[:tag])
  end

  #######################
  # PARTICIPANT ACTIONS #
  #######################

  def show_user
    @user = User.find(params[:id])
  end

  def edit_user_form
    @user = User.find(params[:id])
  end

  def show_event
    @event = Event.find(params[:id])
  end

  #################
  # OWNER ACTIONS #
  #################

  def new_event_form
    @event = Event.new
    @locations = Location.joins(:owner).where(users: {id: session[:user_id]})
  end

  def edit_event_form
    @event = Event.find(params[:id])
    @locations = Location.joins(:owner).where(users: {id: session[:user_id]})
    
    unless @event.owner.include? @current_user or @current_user.admin? 
      flash[:danger] = Messages::ErrorMessages::UnauthorizedAccess
      redirect_to show_user_path(@current_user)
    end
  end

  def new_location_form
    @location = Location.new
  end

  def show_location
    @location = Location.find(params[:id])
    unless @location.owner.include? @current_user or @current_user.admin?
      flash[:danger] = Messages::ErrorMessages::UnauthorizedAccess
      redirect_to show_user_path(@current_user)
    end
  end

  def edit_location_form
    @location = Location.find(params[:id])
    unless @location.owner.include? @current_user or @current_user.admin?
      flash[:danger] = Messages::ErrorMessages::UnauthorizedAccess
      redirect_to show_user_path(@current_user)
    end
  end

  #################
  # ADMIN ACTIONS #
  #################

  def show_all_events
    @events = Event.all
  end

  def show_all_locations
    @locations = Location.all
  end

  def show_all_users
    @users = User.where.not(first_name: 'guest')
  end

  def new_option_form
    @option = Option.any? ? Option.last : Option.new
  end

  def edit_option_form
    @option = Option.last
  end
end