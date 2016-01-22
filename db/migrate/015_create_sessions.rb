class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.datetime :deleted_at
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end