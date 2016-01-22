class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles, id: false do |t|
      t.belongs_to :permission, index: true
      t.belongs_to :role, index: true
    end
  end
end