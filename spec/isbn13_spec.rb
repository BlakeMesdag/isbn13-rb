# frozen_string_literal: true

RSpec.describe Isbn13 do
  it "has a version number" do
    expect(Isbn13::VERSION).not_to be nil
  end

  context "Integer barcodes" do
    it "checksum calculated for barcodes without one" do
      expect(Isbn13::Barcode.new(978014300723).checksum).to eq(4)
    end

    it "work with existing checksums" do
      expect(Isbn13::Barcode.new(9780143007234).checksum).to eq(4)
    end

    it "#has_valid_checksum? works" do
      valid_barcode = Isbn13::Barcode.new(9780143007234)
      invalid_barcode = Isbn13::Barcode.new(9780143007231)

      expect(valid_barcode.has_valid_checksum?).to eq(true)
      expect(invalid_barcode.has_valid_checksum?).to eq(false)
    end
  end

  context "String barcodes" do
    it "work without a checksum" do
      expect(Isbn13::Barcode.new("978014300723").checksum).to eq(4)
    end

    it "work with a checksum" do
      expect(Isbn13::Barcode.new("9780143007234").checksum).to eq(4)
    end

    it "work with dashes" do
      expect(Isbn13::Barcode.new("978-0-143-00723").checksum).to eq(4)
    end

    it "work with dashes with a checksum" do
      expect(Isbn13::Barcode.new("978-0-143-00723-4").checksum).to eq(4)
    end

    it "work with 0 sum checksum" do
      zero_checksum = Isbn13::Barcode.new("978-0-543-00723-0")

      expect(zero_checksum.checksum).to eq(0)
      expect(zero_checksum.has_valid_checksum?).to eq(true)
    end

    it "#has_valid_checksum? works" do
      valid_barcode = Isbn13::Barcode.new("9780143007234")
      invalid_barcode = Isbn13::Barcode.new("9780143007234", checksum: 1)

      expect(valid_barcode.has_valid_checksum?).to eq(true)
      expect(invalid_barcode.has_valid_checksum?).to eq(false)
    end
  end
end
