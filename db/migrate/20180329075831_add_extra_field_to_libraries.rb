class AddExtraFieldToLibraries < ActiveRecord::Migration
  def change
  	add_column :libraries, :library_data, :text
  end
end
