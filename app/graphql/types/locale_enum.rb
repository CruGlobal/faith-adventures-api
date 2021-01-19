# frozen_string_literal: true

class Types::LocaleEnum < Types::BaseEnum
  I18n.available_locales.each do |locale|
    value locale.to_s.underscore.upcase, value: locale.to_s
  end
end
