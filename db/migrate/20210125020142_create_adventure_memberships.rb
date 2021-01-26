# frozen_string_literal: true

class CreateAdventureMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :adventure_memberships, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.belongs_to :adventure, null: false, foreign_key: { on_delete: :cascade }, type: :uuid

      t.timestamps
    end

    add_index :adventure_memberships, %i[user_id adventure_id], unique: true
  end
end
