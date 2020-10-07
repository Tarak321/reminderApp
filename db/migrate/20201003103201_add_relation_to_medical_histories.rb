class AddRelationToMedicalHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :medical_histories, :relation, :string
  end
end
