class CreatePermissionsTasks < ActiveRecord::Migration
  def change
    create_table :permissions_tasks, id: false do |t|
      t.belongs_to :permission, index: true
      t.belongs_to :task, index: true
    end
  end
end