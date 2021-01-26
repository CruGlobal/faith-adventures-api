# frozen_string_literal: true

class Adventure::Step::FormField::DateField < Adventure::Step::FormField
  validate :validate_min_valid_value
  validate :validate_max_valid_value

  def add_validation_errors(response)
    return if response.value.blank?
    return response.errors.add :value, 'must be a valid date' unless valid_date?(response.value)

    date = Date.iso8601(response.value)
    valid_min(response, date)
    valid_max(response, date)
  end

  private

  def valid_min(response, date)
    return unless min.present?

    min_date = Date.parse(min)
    response.errors.add :value, "can't be before #{min_date}" if date < min_date
  end

  def valid_max(response, date)
    return unless max.present?

    max_date = Date.parse(max)
    response.errors.add :value, "can't be after #{max_date}" if date > max_date
  end

  def valid_date?(value)
    Date.iso8601(value)
    true
  rescue Date::Error
    false
  end

  def validate_min_valid_value
    Date.iso8601(min) if min.present?
  rescue Date::Error
    errors.add :min, 'must be a valid date'
  end

  def validate_max_valid_value
    Date.iso8601(max) if max.present?
  rescue Date::Error
    errors.add :max, 'must be a valid date'
  end
end
