# frozen_string_literal: true

class Types::Adventure::StepType < Types::BaseRecord
  class StateEnum < Types::BaseEnum
    graphql_name 'AdventureStepStateEnum'
    value 'LOCKED'
    value 'COMPLETED'
    value 'ACTIVE'
  end

  field :name, type: String, null: false
  field :slug, type: String, null: false
  field :content, type: Types::ContentInterface, null: false
  field :state, type: StateEnum, null: false
  field :position, type: Integer, null: false
  field :adventure, type: Types::AdventureType, null: false
  field :form_fields, Types::Adventure::Step::FormFieldInterface.connection_type, null: false
  field :after_response_message, type: String, null: true

  def state
    return 'LOCKED' if locked?
    return 'COMPLETED' if completed?
    return 'ACTIVE' if active?

    'LOCKED'
  end

  protected

  def locked?
    context[:current_user].nil? || object.adventure.template.nil?
  end

  def completed?
    object.responses.where(user: context[:current_user]).exists?
  end

  def active?
    object.first? || object.higher_item.responses.where(user: context[:current_user]).exists?
  end
end
