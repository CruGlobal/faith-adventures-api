# frozen_string_literal: true

class Types::MutationType < Types::BaseObject
  field :adventure_start, resolver: Mutations::Adventure::StartMutation
  field :adventure_create, resolver: Mutations::Adventure::CreateMutation
  field :adventure_update, resolver: Mutations::Adventure::UpdateMutation
  field :adventure_destroy, resolver: Mutations::Adventure::DestroyMutation
  field :adventure_step_create, resolver: Mutations::Adventure::Step::CreateMutation
  field :adventure_step_update, resolver: Mutations::Adventure::Step::UpdateMutation
  field :adventure_step_destroy, resolver: Mutations::Adventure::Step::DestroyMutation
  field :adventure_step_form_field_create, resolver: Mutations::Adventure::Step::FormField::CreateMutation
  field :adventure_step_form_field_update, resolver: Mutations::Adventure::Step::FormField::UpdateMutation
  field :adventure_step_form_field_destroy, resolver: Mutations::Adventure::Step::FormField::DestroyMutation
  field :adventure_step_form_field_response_bulk_upsert,
        resolver: Mutations::Adventure::Step::FormField::Response::BulkUpsertMutation
  field :content_view_create, resolver: Mutations::Content::View::CreateMutation
  field :content_like_toggle, resolver: Mutations::Content::Like::ToggleMutation
  field :content_dislike_toggle, resolver: Mutations::Content::Dislike::ToggleMutation
end
