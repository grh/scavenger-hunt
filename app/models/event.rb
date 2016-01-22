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
end