# frozen_string_literal: true

class AddMissingTaggableIndex < ActiveRecord::Migration[6.0]
  def up
    add_index ActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type context], name: 'taggings_taggable_context_idx'
  end

  def down
    remove_index ActsAsTaggableOn.taggings_table, name: 'taggings_taggable_context_idx'
  end
end
