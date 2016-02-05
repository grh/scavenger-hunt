class HtmlController < ApplicationController
  
  skip_before_action :install, only: :new_user_form
  ##################
  # PUBLIC ACTIONS #
  ##################

  def home
    @current_events = Event.current
    @upcoming_events = Event.upcoming
  end

  def about
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
  end

  def new_location_form
    @location = Location.new
  end

  def show_location
    @location = Location.find(params[:id])
  end

  def edit_location_form
    @location = Location.find(params[:id])
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
    @users = User.all
  end
end