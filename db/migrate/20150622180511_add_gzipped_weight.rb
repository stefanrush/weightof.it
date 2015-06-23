class AddGzippedWeight < ActiveRecord::Migration
  def change
    add_column :libraries, :weight_gzipped, :integer
    add_column :versions,  :weight_gzipped, :integer
  end
end
