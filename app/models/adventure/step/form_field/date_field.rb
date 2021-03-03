# frozen_string_literal: true

class Adventure::Step::FormField::DateField < Adventure::Step::FormField
  validate :validate_min_date_valid_value
  validate :validate_max_date_valid_value
  store_accessor :metadata, :max_date, :min_date

  def add_validation_errors(response)
    return if response.value.blank?
    return response.errors.add :value, 'must be a valid date' unless valid_date?(response.value)

    date = Date.iso8601(response.value)
    valid_min_date(response, date)
    valid_max_date(response, date)
  end

  private

  def valid_min_date(response, date)
    return unless min_date.present?

    response.errors.add :value, "can't be before min_date" if date < Date.iso8601(min_date)
  end

  def valid_max_date(response, date)
    return unless max_date.present?

    response.errors.add :value, "can't be after max_date" if date > Date.iso8601(max_date)
  end

  def valid_date?(value)
    Date.iso8601(value)
    true
  rescue Date::Error
    false
  end

  def validate_min_date_valid_value
    Date.iso8601(min_date) if min_date.present? && !min_date.is_a?(Date)
  rescue Date::Error
    errors.add :min, 'must be a valid date'
  end

  def validate_max_date_valid_value
    Date.iso8601(max_date) if max_date.present? && !max_date.is_a?(Date)
  rescue Date::Error
    errors.add :max, 'must be a valid date'
  end
end
