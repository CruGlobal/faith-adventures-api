# frozen_string_literal: true

class AddLikesAndDislikesToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :likes_count, :integer, null: false, default: 0
    add_column :contents, :dislikes_count, :integer, null: false, default: 0
  end
end
