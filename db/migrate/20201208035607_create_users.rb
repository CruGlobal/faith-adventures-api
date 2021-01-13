# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :sub, null: false
      t.string :given_name
      t.string :family_name
      t.string :nickname
      t.string :name
      t.string :picture
      t.string :locale
      t.string :email
      t.boolean :email_verified

      t.timestamps
    end

    add_index :users, :sub, unique: true
  end
end
