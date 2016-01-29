class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  ################
  # ASSOCIATIONS #
  ################

  # event/user associations
  has_and_belongs_to_many :owned_events, class_name: 'Event', join_table: 'owned_events'
  has_many :joins
  has_many :participating_events, through: :joins, source: 'event'

  # location/user associations
  has_and_belongs_to_many :owned_locations, class_name: 'Location', join_table: 'owned_locations'
  has_many :visits
  has_many :visited_locations, through: :visits, source: 'location'

  # session/user associations
  has_many :sessions

  # role/user assocations
  has_and_belongs_to_many :roles

  ###############
  # VALIDATIONS #
  ###############

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\w+@\w+\.\w+/, message: "email address is not a valid format"}
  validates :email, format: {without: /\s+/, message: "email address cannot contain spaces"}
  validates :password, length: {minimum: 8, message: "password must be at least 8 characters long"}
  validates :password, format: {without: /\s+/, message: "password cannot contain any spaces"}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: "password.present?"

  #################
  # CLASS METHODS #
  #################

  # for each role, add an instance method that
  # returns whether or not the user has that role
  # (i.e., user.admin?, user.owner?, etc.)
  Role.all.each do |role|
    define_method (role.name + "?").to_sym do
      return self.roles.include? Role.find_by_name role.name
    end
  end

  # for each role, add a class method
  # that returns all users with that role
  # (i.e., User.admins, User.owners, etc.)
  Role.all.each do |role|
    define_singleton_method (role.name + 's').to_sym do
      return Role.find_by_name(role.name).users
    end
  end

  # authenticate: class method that checks login credentials
  # parameters: email and password
  # return value: a user if authenticated, otherwise nil
  def self.authenticate(user_params)
    @user = User.find_by_email(user_params[:email])
    if @user and @user.password_hash == BCrypt::Engine.hash_secret(user_params[:password], @user.password_salt)
      return @user
    else
      return nil
    end
  end

  # current_user: returns a user object for the given session
  #               or the guest user if no session
  # parameters: session hash
  # return value: a user object
  def self.current_user(session)
    return (session[:user_id] ? User.find(session[:user_id]) : User.guest)
  end

  # guest: returns a guest user with guest privileges
  # parameters: none
  # return value: a guest user
  def self.guest
    return User.find_by(first_name: 'guest', last_name: 'guest')
  end

  ####################
  # INSTANCE METHODS #
  ####################

  # authorized?: check to see if a user can perform a task
  # parameters: a task
  # return value: true/false
  def authorized?(current_task)
    authorized = false
    self.roles.each do |role|
      unless (role.permissions & current_task.permissions).empty?
        authorized = true
        break
      end
    end
    new_user_form_task = Task.find_by(controller: 'html', action: 'new_user_form', request_method: 'GET')
    if User.admins.empty?  and (current_task == new_user_form_task)
      puts "#{User.admins.empty?} #{current_task} #{new_user_form_task}"
      authorized = true
    end
    return authorized
  end

  # permitted?: check to see if a user is permitted to access a page
  #             based on the request parameters
  # parameters: a request path
  # return value: true or false
  def permitted?(request_path)
    permitted = true
    case request_path
      when /\/user\/([0-9]+)/
        permitted = false unless self.id.to_s == $1
    end
    return permitted
  end

  # create: given an existing user object, set the appropriate values
  #         update roles, and insert into db
  # parameters: none
  # return value: true/false, depending on success/failure of creation
  def create
    status = false
    if self.save
      self.roles << Role.default
      status = true
    end
    return status
  end

  # join: user becomes participant of event
  # parameters: an event
  # return value: success or failure of join
  def join(event)
    self.participating_events << event unless event.participants.include? self
    return event.participants.include? self
  end

  # leave: user leaves an event
  # parameters: an event
  # return value: success or failure
  def leave(event)
    self.participating_events.delete(event)
    return (not self.participating_events.include? event)
  end

  # visit: user visits a location
  # parameters: a location
  # return value: success or failure
  def visit(location)
    location_valid = false
    self.participating_events.each do |event|
      if event.locations.include? location
        location_valid = true
        break
      end
    end

    self.visited_locations << location if location_valid

    return self.visited_locations.include? location
  end

  # owns?: tells us whether user owns an event or not
  # parameters: an event
  # return value: is the event owner this user?
  def owns?(event)
    return event.owner.include? self
  end

  # unvisited: list all locations not visited for a particular event
  # parameters: an event
  # return value: a list of unvisited locations for that event
  def unvisited(event)
    return event.locations - self.visited_locations
  end

  # visited: list all locations visited for a particular event
  # parameters: an event
  # return value: a list of visited location for that event
  def visited(event)
    return self.visited_locations & event.locations
  end

  # percent_complete: calculated completion percentage for an event
  # parameters: an event
  # return value: percent of locations visited for that event
  def progress(event)
    return (event.locations.empty? ? 100 : ((visited(event).size.to_f / event.locations.size.to_f) * 100).round)
  end

  private

  # encrypt_password: hash the user's password
  # parameters: none
  # return value: none
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
    end
  end
end