class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string     :name,              null: false
      t.string     :slug,              null: false
      t.string     :source_url,        null: false
      t.string     :homepage_url
      t.string     :description
      t.integer    :popularity
      t.references :category,          null: false, index: true
      t.boolean    :check_description, null: false, default: true
      t.boolean    :check_popularity,  null: false, default: true
      t.boolean    :active,            null: false, default: true
      t.timestamps                     null: false
    end
  end
end
