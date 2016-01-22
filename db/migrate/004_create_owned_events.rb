class CreateOwnedEvents < ActiveRecord::Migration
  def change
    create_table :owned_events, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
    end
  end
end
