class AddSearchToProviders < ActiveRecord::Migration[5.1]
  def change
    add_reference :providers, :search, foreign_key: true
  end
end
