# frozen_string_literal: true

class Types::BaseConnection < GraphQL::Types::Relay::BaseConnection
  field :total_count, Integer, 'Total # of objects returned from this Plural Query', null: false
  field :total_page_count, Integer, 'Total # of pages, based on total count and pagesize', null: false

  def total_count
    return 0 if object.items.nil?

    base_klass.from(object.items).count
  end

  def total_page_count
    return 1 unless object.items.nil?

    my_total_count = total_count

    return 1 unless my_total_count.positive?

    # get total count and create array with total count as first item
    possible_page_sizes = [my_total_count]

    # add first and last argument counts to the array if they exist
    possible_page_sizes.push(object.arguments[:first]) if object.arguments[:first]
    possible_page_sizes.push(object.arguments[:last]) if object.arguments[:last]

    # get the smallest of the array items
    actual_page_size = possible_page_sizes.min

    # return the total_count divided by the page size, rounded up
    (my_total_count / actual_page_size.to_f).ceil
  end

  private

  def base_klass
    object.items&.class&.to_s&.deconstantize&.constantize
  end
end
