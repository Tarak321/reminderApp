class AddBloodGroupToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :blood_group, :string
  end
end
