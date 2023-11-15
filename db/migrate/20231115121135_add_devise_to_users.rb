# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      unless column_exists?(:users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      ## Recoverable
      unless column_exists?(:users, :reset_password_token)
        t.string :reset_password_token
        t.datetime :reset_password_sent_at
      end

      ## Rememberable
      unless column_exists?(:users, :remember_created_at)
        t.datetime :remember_created_at
      end

      # ... (other Devise modules)

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    # Check if the index exists before trying to create it
    add_index :users, :email, unique: true unless index_exists?(:users, :email)

    # ... (other Devise indexes)
  end

  def self.down
    # You might want to implement a rollback if needed
    raise ActiveRecord::IrreversibleMigration
  end
end
