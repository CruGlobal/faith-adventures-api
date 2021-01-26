# frozen_string_literal: true

class CreateAdventureStepFormFields < ActiveRecord::Migration[6.0]
  def change
    create_table :adventure_step_form_fields, id: :uuid do |t|
      t.belongs_to :step, null: false, foreign_key: { on_delete: :cascade, to_table: :adventure_steps }, type: :uuid
      t.string :type, null: false
      t.string :name, null: false
      t.string :min
      t.string :max
      t.boolean :required, default: false, null: false

      t.timestamps
    end
  end
end
