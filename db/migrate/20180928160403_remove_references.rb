class RemoveReferences < ActiveRecord::Migration[5.1]
  def change
    remove_column :providers, :search_id, :integer
    remove_column :brands, :search_id, :integer
  end
end
