# frozen_string_literal: true

class Types::MutationType < Types::BaseObject
  field :adventure_start, resolver: Mutations::Adventure::StartMutation
  field :adventure_step_form_field_response_bulk_upsert,
        resolver: Mutations::Adventure::Step::FormField::Response::BulkUpsertMutation
end
