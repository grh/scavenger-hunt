class Location < ActiveRecord::Base
  # location/user associations
  has_and_belongs_to_many :owner, class_name: 'User', join_table: 'owned_locations'
  has_many :visits
  has_many :visitors, through: :visits, source: 'user'

  # event/location associations
  has_and_belongs_to_many :events
end