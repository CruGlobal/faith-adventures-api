# frozen_string_literal: true

class Adventure::Step::FormField::RadioField < Adventure::Step::FormField
  INTEGER_REGEX = /\A[+-]?\d+\Z/.freeze
  store_accessor :metadata, :options
  validate :validate_options_value

  def add_validation_errors(response)
    return unless response.value.present?

    valid_option(response, response.value)
  end

  private

  def valid_option(response, value)
    response.errors.add :value, "can't be outside of available options" unless options.include?(value)
  end

  def validate_options_value
    return errors.add :options, 'must be an array' unless options.is_a?(Array)

    options.each do |option|
      errors.add :options, 'must be an array of strings' unless option.is_a?(String)
    end
  end
end
