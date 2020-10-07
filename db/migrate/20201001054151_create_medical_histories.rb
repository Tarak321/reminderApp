class CreateMedicalHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_histories do |t|
      t.string :illness
      t.string :drname
      t.string :medicine
      t.date :start_date
      t.date :end_date
      t.string :dosage_amount
      t.string :dosage_frequency
      t.string :dosage_time
      t.boolean :email_notify
      t.references :user, null: false, foreign_key: true
      t.references :dependent, null: true, foreign_key: true

      t.timestamps
    end
  end
end
