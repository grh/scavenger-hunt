class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :logo
      t.string :color
    end
  end
end