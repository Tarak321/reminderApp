class CreateDependents < ActiveRecord::Migration[6.0]
  def change
    create_table :dependents do |t|
      t.string :relationship
      t.string :name
      t.string :email_address
      t.string :contact_number
      t.string :blood_group
      t.date :date_of_birth
      t.string :weight
      t.string :height
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
