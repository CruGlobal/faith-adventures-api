# frozen_string_literal: true

class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents, id: :uuid do |t|
      t.string :locale, null: false
      t.string :name, null: false
      t.text :description
      t.string :type, null: false
      t.jsonb :metadata, null: false, default: '{}'
      t.timestamps
    end

    add_index :contents, :metadata, using: :gin
  end
end
