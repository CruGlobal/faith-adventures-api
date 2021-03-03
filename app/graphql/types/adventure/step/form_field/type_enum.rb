# frozen_string_literal: true

class Types::Adventure::Step::FormField::TypeEnum < Types::BaseEnum
  value 'DATE', value: 'Adventure::Step::FormField::DateField'
  value 'NUMBER', value: 'Adventure::Step::FormField::NumberField'
  value 'RADIO', value: 'Adventure::Step::FormField::RadioField'
  value 'STRING', value: 'Adventure::Step::FormField::StringField'
end
