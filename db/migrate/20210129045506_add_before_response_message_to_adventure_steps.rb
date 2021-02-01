# frozen_string_literal: true

class AddBeforeResponseMessageToAdventureSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :adventure_steps, :before_response_message, :string
  end
end
