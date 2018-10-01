class AddJoinTables < ActiveRecord::Migration[5.1]
  def change
    create_table :brands_searches, id: false do |t|
      t.integer :search_id
      t.integer :brand_id
    end

    add_index :brands_searches, :search_id
    add_index :brands_searches, :brand_id

    create_table :providers_searches, id: false do |t|
      t.integer :search_id
      t.integer :provider_id
    end

    add_index :providers_searches, :search_id
    add_index :providers_searches, :provider_id
  end
end
