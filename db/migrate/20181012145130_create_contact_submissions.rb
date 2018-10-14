class CreateContactSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_submissions do |t|
      t.string :email
      t.string :name
      t.text :message

      t.timestamps
    end
  end
end
