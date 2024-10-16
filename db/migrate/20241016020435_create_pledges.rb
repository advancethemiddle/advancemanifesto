class CreatePledges < ActiveRecord::Migration[7.2]
  def change
    create_table :pledges, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
