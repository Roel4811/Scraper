class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :image
      t.string :link
      t.string :rating
      t.integer :review_amount
      t.string :latest_order_time
    end
  end
end
