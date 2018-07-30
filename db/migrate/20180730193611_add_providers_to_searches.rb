class AddProvidersToSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :providers, :string
  end
end
