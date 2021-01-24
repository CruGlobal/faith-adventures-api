# frozen_string_literal: true

class AddFeaturedToAdventures < ActiveRecord::Migration[6.0]
  def change
    add_column :adventures, :featured, :boolean
  end
end
