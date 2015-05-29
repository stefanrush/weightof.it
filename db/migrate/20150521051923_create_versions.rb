class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :library, null: false, index: true
      t.string     :number,  null: false
      t.string     :raw_url, null: false
      t.integer    :weight
      t.boolean    :active,  null: false, default: true
      t.timestamps           null: false
    end
  end
end
