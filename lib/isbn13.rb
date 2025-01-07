# frozen_string_literal: true

require_relative "isbn13/version"

module Isbn13
  def self.extract_integer(str)
    str.delete("^0-9").to_i
  end

  def self.checksum(input)
    if input.is_a?(String)
      checksum_from_string(input)
    else
      checksum_from_integer(input)
    end
  end

  def self.has_valid_checksum?(isbn)
    ints = if isbn.is_a?(String)
      extract_integer(isbn)
    else
      isbn
    end.digits.reverse

    if ints.size != 13
      return false
    end

    checksum(isbn) == ints.last
  end

  def self.checksum_from_string(str)
    # All ISBNs start with 978 or 979 so we don't have to worry about any leading 0s getting cut off
    checksum_from_integer(extract_integer(str))
  end

  def self.checksum_from_integer(input)
    digits = input.digits.reverse # Take all the digits separately, reverse since digits does a mod(10) extraction into an array

    # Only take the first 12 digits
    digits = digits.take(12)

    # Separate the even and odd numbers
    evens = digits.slice((0..).step(2))
    odds = digits.slice((1..).step(2))

    sums = (evens.sum + (odds.sum * 3)) % 10

    # 10 values are 0 which we can just mod away
    (10 - sums) % 10
  end
end
