# frozen_string_literal: true

class CreateContentLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :content_likes, id: :uuid do |t|
      t.belongs_to :content, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }, type: :uuid

      t.timestamps
    end
    add_index :content_likes, %i[content_id user_id], unique: true
  end
end
