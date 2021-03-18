# frozen_string_literal: true

class Mutations::Content::Like::ToggleMutation < Mutations::AuthenticatedMutation
  graphql_name 'ContentLikeToggleMutation'
  argument :id, ID, required: true, description: 'Can be ID or slug of content'
  field :like, Types::Content::LikeType, null: false

  def resolve(id:)
    content = Content.friendly.find(id)
    like = context[:current_user].likes.find_by(content: content)

    if like
      like.destroy
    else
      like = context[:current_user].likes.create(content: content)
    end

    { like: like }
  end
end
