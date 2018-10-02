class RemoveIndexes < ActiveRecord::Migration[5.1]
  def change
    remove_index :providers_searches, column: [:provider_id]
    remove_index :providers_searches, column: [:search_id]

    remove_index :brands_searches, column: [:brand_id]
    remove_index :brands_searches, column: [:search_id]
  end
end
