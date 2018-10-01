class DropJoinTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :searches_brands
    drop_table :searches_providers
  end
end
