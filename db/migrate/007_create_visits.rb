class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.belongs_to :location, index:true
      t.belongs_to :user, index:true
      t.timestamps null: false
    end
  end
end