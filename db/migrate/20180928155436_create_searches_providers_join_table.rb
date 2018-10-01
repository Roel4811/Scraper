class CreateSearchesProvidersJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :searches_providers, id: false do |t|
      t.integer :search_id
      t.integer :provider_id
    end

    add_index :searches_providers, :search_id
    add_index :searches_providers, :provider_id
  end
end
