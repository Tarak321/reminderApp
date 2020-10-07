class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :email_address
      t.string :contact_number
      t.string :country
      t.date :date_of_birth

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
