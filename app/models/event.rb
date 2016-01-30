class Event < ActiveRecord::Base
  # event/user associations
  has_and_belongs_to_many :owner, class_name: 'User', join_table: 'owned_events'
  has_many :joins
  has_many :participants, through: :joins, source: 'user'

  # event/location associations
  has_and_belongs_to_many :locations

  # recent: list recent events
  # parameters: none
  # return value: a collection of recent events that are either
  #               ongoing or finished within the last 2 weeks
  def self.current
    where("start_date <= ? AND end_date >= ?", Date.today, Date.today).order(end_date: :desc)
  end

  # upcoming: list upcoming events
  # parameters: none
  # return value: a collection of upcoming events
  #               that begin in the next 2 weeks
  def self.upcoming
    where(start_date: (Date.today+1)..(Date.today+2.weeks)).order(start_date: :asc)
  end

  # save?: saves a given event
  # parameters: event_params
  # return value: success or failure
  def save?(locations, user)
    saved = self.save ? true : false

    # update owner info
    self.owner << user

    # update location info
    Location.find(locations).each do |location|
      unless self.locations.include? location
        self.locations << location
      end
    end

    return saved
  end

  # update?: updates a given event
  # parameters: event_params
  # return value: success or failure
  def update?(event_params, locations)
    saved = self.update(event_params) ? true : false

    # delete existing locations from event
    self.locations.each do |location|
      unless Location.find(locations).include? location
        self.locations.delete(location)
      end
    end

    # add new locations to event
    Location.find(locations).each do |location|
      unless self.locations.include? location
        self.locations << location
      end
    end

    return saved
  end
end