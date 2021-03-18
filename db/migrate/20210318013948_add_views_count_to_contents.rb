# frozen_string_literal: true

class AddViewsCountToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :views_count, :integer, null: false, default: 0
  end
end
