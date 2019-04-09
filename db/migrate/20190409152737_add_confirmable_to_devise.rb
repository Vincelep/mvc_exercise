class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    change_table :admins, bulk: true do |t|
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.index :confirmation_token, unique: true
    end
  end
end
