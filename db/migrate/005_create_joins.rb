class CreateJoins < ActiveRecord::Migration
  def change
    create_table :joins do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end