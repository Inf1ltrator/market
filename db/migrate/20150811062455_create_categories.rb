class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps null: false
    end
    change_table :items do |t|
      t.belongs_to :category, index: true
    end
  end
end