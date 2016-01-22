class CreateEventsLocations < ActiveRecord::Migration
  def change
    create_table :events_locations, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :location, index: true
    end
  end
end