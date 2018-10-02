class AddUniqueIndexesToJoinTables < ActiveRecord::Migration[5.1]
  def change
    add_index :brands_searches, [:brand_id, :search_id], unique: true
    add_index :brands_searches, :search_id

    add_index :providers_searches, [:provider_id, :search_id], unique: true
    add_index :providers_searches, :search_id
  end
end
