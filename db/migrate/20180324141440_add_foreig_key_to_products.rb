class AddForeigKeyToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :provider_id, :integer
    add_foreign_key :products, :providers
  end
end
