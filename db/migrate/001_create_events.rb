class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end