class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.text :description
      t.string :coordinates
      t.string :tag
      t.timestamps null: false
    end
  end
end