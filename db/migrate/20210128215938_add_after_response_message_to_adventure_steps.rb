# frozen_string_literal: true

class AddAfterResponseMessageToAdventureSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :adventure_steps, :after_response_message, :string
  end
end
