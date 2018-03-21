class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries, {:id => false} do |t|
      t.integer :red_id
      t.date :purchased_on
      t.integer :user_id
      t.text :description

      t.timestamps null: false
    end
  end
end
