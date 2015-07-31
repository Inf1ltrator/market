class AddDescriptionColumnToItems < ActiveRecord::Migration
  def change
  	add_column :items, :description, :string
  	add_index :items, :name
  	add_index :items, :price
  end
end
