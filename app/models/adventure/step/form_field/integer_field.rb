# frozen_string_literal: true

class Adventure::Step::FormField::IntegerField < Adventure::Step::FormField
  INTEGER_REGEX = /\A[+-]?\d+\Z/.freeze
  validates :min, format: { with: INTEGER_REGEX, message: 'must be a valid number', allow_blank: true }
  validates :max, format: { with: INTEGER_REGEX, message: 'must be a valid number', allow_blank: true }

  def add_validation_errors(response)
    return if response.value.blank?
    return response.errors.add :value, 'must be a valid number' unless valid_integer?(response.value)

    integer = response.value.to_i
    valid_min(response, integer)
    valid_max(response, integer)
  end

  private

  def valid_min(response, value)
    return unless min.present?

    response.errors.add :value, "can't be less than #{min}" if min.present? && value < min.to_i
  end

  def valid_max(response, value)
    return unless max.present?

    response.errors.add :value, "can't be greater than #{max}" if max.present? && value > max.to_i
  end

  def valid_integer?(value)
    value.match(INTEGER_REGEX)
  end
end
