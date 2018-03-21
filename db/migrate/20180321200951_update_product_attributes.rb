class UpdateProductAttributes < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :latest_order_time, :string
    add_column :products, :available, :boolean
    add_column :products, :availability, :string
  end
end
