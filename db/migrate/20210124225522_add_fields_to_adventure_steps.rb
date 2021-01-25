# frozen_string_literal: true

class AddFieldsToAdventureSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :adventure_steps, :name, :string, null: false
    add_column :adventure_steps, :slug, :string
    add_index :adventure_steps, :slug, unique: true
  end
end
