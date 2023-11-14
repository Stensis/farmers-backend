class CreateFarmers < ActiveRecord::Migration[7.1]
  def change
    create_table :farmers do |t|
      t.string :full_name
      t.string :email
      t.integer :tel
      t.string :location

      t.timestamps
    end
  end
end
