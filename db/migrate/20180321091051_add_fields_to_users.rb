class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :user_type, :string
  	add_column :users, :contact_number, :string
  	add_column :users, :address, :string
  end
end
