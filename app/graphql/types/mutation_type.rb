# frozen_string_literal: true

class Types::MutationType < Types::BaseObject
  field :adventure_start, resolver: Mutations::Adventure::StartMutation
end
