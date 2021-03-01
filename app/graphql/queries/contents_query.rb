# frozen_string_literal: true

class Queries::ContentsQuery < Queries::ApplicationQuery
  description 'List of contents'
  type Types::ContentInterface.connection_type, null: false
  argument :featured, Boolean, required: false
  argument :locale, Types::LocaleEnum, required: false
  argument :search, String, required: false

  def resolve(featured: nil, locale: nil, search: nil)
    scope = Content.published.order(:name)
    scope = scope.where(featured: featured ? true : [false, nil]) unless featured.nil?
    scope = scope.where(locale: locale) unless locale.nil?
    scope = scope.where('lower(name) LIKE :search', search: "%#{search.downcase}%") if search
    scope
  end
end
