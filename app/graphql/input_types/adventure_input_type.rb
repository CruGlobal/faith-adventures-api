# frozen_string_literal: true

class InputTypes::AdventureInputType < Types::BaseInputObject
  description 'Attributes for creating an adventure'
  argument :id, ID, required: false
  argument :name, String, required: true
  argument :description, String, required: false
  argument :content_id, ID, required: true
  argument :locale, Types::LocaleEnum, required: true
end
