# frozen_string_literal: true

class AddSlugToContents < ActiveRecord::Migration[6.0]
  class Content < ApplicationRecord
    self.inheritance_column = nil
    extend FriendlyId
    friendly_id :name, use: :slugged
  end

  def change
    add_column :contents, :slug, :string
    add_index :contents, :slug, unique: true
    Content.find_each(&:save)
  end
end
