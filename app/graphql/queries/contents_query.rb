# frozen_string_literal: true

class Queries::ContentsQuery < Queries::ApplicationQuery
  description 'List of contents'
  type Types::ContentInterface.connection_type, null: false

  def resolve
    Content.all
  end
end
