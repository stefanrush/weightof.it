class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name,     null: false
      t.string  :slug,     null: false
      t.integer :position, null: false, default: 0
      t.boolean :active,   null: false, default: true
      t.timestamps         null: false
    end
  end
end
