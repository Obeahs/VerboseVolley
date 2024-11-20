# frozen_string_literal: true

class AddDeviseToCustomers < ActiveRecord::Migration[7.2]
  def self.up
    change_table :customers do |t|
      ## Database authenticatable
      t.change :email, :string, null: false, default: "" if column_exists?(:customers, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:customers, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:customers, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:customers, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:customers, :remember_created_at)

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false unless column_exists?(:customers, :sign_in_count)
      # t.datetime :current_sign_in_at unless column_exists?(:customers, :current_sign_in_at)
      # t.datetime :last_sign_in_at unless column_exists?(:customers, :last_sign_in_at)
      # t.string   :current_sign_in_ip unless column_exists?(:customers, :current_sign_in_ip)
      # t.string   :last_sign_in_ip unless column_exists?(:customers, :last_sign_in_ip)

      ## Confirmable
      # t.string   :confirmation_token unless column_exists?(:customers, :confirmation_token)
      # t.datetime :confirmed_at unless column_exists?(:customers, :confirmed_at)
      # t.datetime :confirmation_sent_at unless column_exists?(:customers, :confirmation_sent_at)
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false unless column_exists?(:customers, :failed_attempts) # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token unless column_exists?(:customers, :unlock_token) # Only if unlock strategy is :email or :both
      # t.datetime :locked_at unless column_exists?(:customers, :locked_at)

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :customers, :email,                unique: true unless index_exists?(:customers, :email)
    add_index :customers, :reset_password_token, unique: true unless index_exists?(:customers, :reset_password_token)
    # add_index :customers, :confirmation_token,   unique: true unless index_exists?(:customers, :confirmation_token)
    # add_index :customers, :unlock_token,         unique: true unless index_exists?(:customers, :unlock_token)
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
