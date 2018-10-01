class CreateSearchesBrandsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :searches_brands, id: false do |t|
      t.integer :search_id
      t.integer :brand_id
    end

    add_index :searches_brands, :search_id
    add_index :searches_brands, :brand_id
  end
end
