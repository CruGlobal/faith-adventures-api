# frozen_string_literal: true

class Mutations::Content::Dislike::ToggleMutation < Mutations::AuthenticatedMutation
  graphql_name 'ContentDislikeToggleMutation'
  argument :id, ID, required: true, description: 'Can be ID or slug of content'
  field :dislike, Types::Content::DislikeType, null: false

  def resolve(id:)
    content = Content.friendly.find(id)
    dislike = context[:current_user].dislikes.find_by(content: content)

    if dislike
      dislike.destroy
    else
      dislike = context[:current_user].dislikes.create(content: content)
    end

    { dislike: dislike }
  end
end
