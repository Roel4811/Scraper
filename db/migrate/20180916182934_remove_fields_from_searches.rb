class RemoveFieldsFromSearches < ActiveRecord::Migration[5.1]
  def change
    remove_column :searches, :brands, :string
    remove_column :searches, :providers, :string
  end
end
