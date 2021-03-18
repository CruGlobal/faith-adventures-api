# frozen_string_literal: true

module Types::ContentInterface
  include Types::BaseInterface
  field :id, ID, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  field :name, String, null: false
  field :slug, String, null: false
  field :description, String, null: true
  field :locale, Types::LocaleEnum, null: false
  field :adventures, Types::AdventureType.connection_type, null: false
  field :views_count, Integer, null: false
  field :likes_count, Integer, null: false
  field :dislikes_count, Integer, null: false
  field :like, Boolean, 'authenticated users likes content', null: false
  field :dislike, Boolean, 'authenticated users dislikes content', null: false
  orphan_types Types::Content::ArclightType

  def like
    context[:current_user]&.likes&.where(content_id: object.id)&.exists? || false
  end

  def dislike
    context[:current_user]&.dislikes&.where(content_id: object.id)&.exists? || false
  end

  def adventures
    scope = Adventure.left_outer_joins(:steps).published
    scope.where(content_id: object.id)
         .or(scope.where({ adventure_steps: { content_id: object.id } }))
         .order('adventures.created_at')
         .distinct
  end

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.type}Type".constantize
    end
  end
end
