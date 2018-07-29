class AddBrandsToSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :brands, :string
  end
end
