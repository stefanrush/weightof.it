class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string     :name,              null: false
      t.string     :slug,              null: false
      t.integer    :weight
      t.string     :source_url,        null: false
      t.string     :homepage_url
      t.string     :description
      t.integer    :popularity
      t.references :category,          null: false, index: true
      t.boolean    :check_description, null: false, default: false
      t.boolean    :check_popularity,  null: false, default: false
      t.boolean    :approved,          null: false, default: false
      t.boolean    :active,            null: false, default: false
      t.timestamps                     null: false
    end
    add_index :libraries, :slug
  end
end
