# frozen_string_literal: true

class Types::Adventure::StepType < Types::BaseRecord
  class StateEnum < Types::BaseEnum
    graphql_name 'AdventureStepStateEnum'
    value 'LOCKED'
    value 'ACTIVE'
  end

  field :name, type: String, null: false
  field :slug, type: String, null: false
  field :content, type: Types::ContentInterface, null: false
  field :state, type: StateEnum, null: false
  field :position, type: Integer, null: false
  field :adventure, type: Types::AdventureType, null: false
  field :form_fields, Types::Adventure::Step::FormFieldInterface.connection_type, null: false

  def state
    return 'LOCKED' unless context[:current_user]
    return 'LOCKED' if object.adventure.template.nil?
    return 'ACTIVE' if object.first?
    return 'ACTIVE' if object.higher_item.responses.where(user: context[:current_user]).exists?

    'LOCKED'
  end
end
