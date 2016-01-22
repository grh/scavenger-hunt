class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :controller
      t.string :action
      t.string :request_method
      t.timestamps null: false
    end
  end
end