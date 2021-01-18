# frozen_string_literal: true

class CreateAdventureSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :adventure_steps, id: :uuid do |t|
      t.belongs_to :adventure, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.belongs_to :content, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.integer :position, null: false
      t.timestamps
    end
  end
end
