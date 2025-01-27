# frozen_string_literal: true

module Isbn13
  class Barcode
    attr_reader :barcode, :checksum, :calculated_checksum

    def initialize(barcode, checksum: nil)
      @barcode = if barcode.is_a?(String)
        extract_integer(barcode)
      else
        barcode
      end

      @checksum = checksum.to_i if checksum
      @checksum ||= @barcode.digits.first if @barcode.digits.size == 13

      @calculated_checksum = calculate_checksum

      @checksum ||= @calculated_checksum
    end

    def has_valid_checksum?
      calculated_checksum == checksum
    end

    private

    def extract_integer(barcode)
      barcode.delete("^0-9").to_i
    end

    def calculate_checksum
      digits = barcode.digits.reverse.take(12)

      evens = digits.slice((0..).step(2))
      odds = digits.slice((1..).step(2))

      sums = evens.sum + (odds.sum * 3) % 10

      (10 - sums) % 10
    end
  end
end
