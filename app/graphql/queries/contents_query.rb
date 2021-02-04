# frozen_string_literal: true

class Queries::ContentsQuery < Queries::ApplicationQuery
  description 'List of contents'
  type Types::ContentInterface.connection_type, null: false
  argument :locale, Types::LocaleEnum, required: false

  def resolve(locale: nil)
    scope = Content.all.order(:name)
    scope = scope.where(locale: locale) unless locale.nil?
    scope
  end
end
