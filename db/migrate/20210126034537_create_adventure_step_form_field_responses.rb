# frozen_string_literal: true

class CreateAdventureStepFormFieldResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :adventure_step_form_field_responses, id: :uuid do |t|
      t.belongs_to :form_field,
                   null: false,
                   foreign_key: { on_delete: :cascade, to_table: :adventure_step_form_fields },
                   type: :uuid
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.text :value
      t.timestamps
    end

    add_index :adventure_step_form_field_responses,
              %i[user_id form_field_id],
              unique: true,
              name: 'idx_responses_on_user_and_form_field'
  end
end
