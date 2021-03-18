# frozen_string_literal: true

class Mutations::Content::View::CreateMutation < Mutations::AuthenticatedMutation
  graphql_name 'ContentViewCreateMutation'
  argument :id, ID, required: true, description: 'Can be ID or slug of content'
  field :view, Types::Content::ViewType, null: false

  def resolve(id:)
    content = Content.friendly.find(id)
    view = context[:current_user].views.find_or_create_by(content: content)

    { view: view }
  end
end
