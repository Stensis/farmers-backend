class CreateFarmers < ActiveRecord::Migration[7.1]
  def change
    create_table :farmers do |t|

      t.timestamps
    end
  end
end
