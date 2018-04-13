class AddIssueToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :issue, :boolean
  end
end
