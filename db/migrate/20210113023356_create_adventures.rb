# frozen_string_literal: true

class CreateAdventures < ActiveRecord::Migration[6.0]
  def change
    create_table :adventures, id: :uuid do |t|
      t.belongs_to :template, null: true, foreign_key: { on_delete: :cascade, to_table: :adventures }, type: :uuid
      t.belongs_to :content, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.string :name, null: false
      t.text :description
      t.boolean :published
      t.string :locale, null: false

      t.timestamps
    end
  end
end
