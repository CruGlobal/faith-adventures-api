# frozen_string_literal: true

class AddPublishedToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :published, :boolean
    add_column :contents, :featured, :boolean
  end
end
