class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :library,      null: false, index: true
      t.string     :number,       null: false
      t.string     :file_url,     null: false
      t.integer    :weight
      t.boolean    :check_weight, null: false, default: false
      t.boolean    :active,       null: false, default: false
      t.timestamps                null: false
    end
  end
end
