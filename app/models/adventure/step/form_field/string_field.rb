# frozen_string_literal: true

class Adventure::Step::FormField::StringField < Adventure::Step::FormField
  INTEGER_REGEX = /\A[+-]?\d+\Z/.freeze
  store_accessor :metadata, :max_length, :min_length
  validates :min_length, format: { with: INTEGER_REGEX, message: 'must be a valid number', allow_blank: true }
  validates :max_length, format: { with: INTEGER_REGEX, message: 'must be a valid number', allow_blank: true }

  def add_validation_errors(response)
    return unless response.value.present?

    valid_min_length(response, response.value)
    valid_max_length(response, response.value)
  end

  private

  def valid_min_length(response, value)
    return unless min_length.present? && value.length < min_length.to_i

    response.errors.add :value, "can't be shorter than #{min_length}"
  end

  def valid_max_length(response, value)
    return unless max_length.present? && value.length > max_length.to_i

    response.errors.add :value, "can't be longer than #{max_length}"
  end
end
