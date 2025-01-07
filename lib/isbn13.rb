# frozen_string_literal: true

require_relative "isbn13/version"

module Isbn13
  class Error < StandardError; end

  def self.checksum(input)
    if input.is_a?(String)
      checksum_from_string(input)
    else
      checksum_from_integer(input)
    end
  end

  def self.checksum_from_string(input)
    checksum_from_integer(input.delete("^0-9").to_i)
  end

  def self.checksum_from_integer(input)
    digits = input.digits.reverse # Take all the digits separately, reverse since digits does a mod(10) extraction into an array

    # Only take the first 12 digits
    digits = digits.take(12)

    # Separate the even and odd numbers
    evens = digits.slice((0..).step(2))
    odds = digits.slice((1..).step(2))

    sums = (evens.sum + (odds.sum * 3)) % 10

    (10 - sums) % 10
  end
end
