# frozen_string_literal: true

RSpec.describe Isbn13 do
  it "has a version number" do
    expect(Isbn13::VERSION).not_to be nil
  end

  context "#checksum works for integer inputs" do
    it "works for integers without a checksum" do
      expect(Isbn13.checksum(978010101010)).to eq(7)
    end

    it "works for integers with an existing checksum" do
      expect(Isbn13.checksum(9780101010107)).to eq(7)
    end
  end

  context "#checksum works for string inputs" do
    it "works for strings without a checksum" do
      expect(Isbn13.checksum("978010101010")).to eq(7)
    end

    it "works for strings with a checksum" do
      expect(Isbn13.checksum("9780101010107")).to eq(7)
    end

    it "works for strings with dashes" do
      expect(Isbn13.checksum("978-0-101-01010")).to eq(7)
    end

    it "works for strings with dashes with a checksum" do
      expect(Isbn13.checksum("978-0-101-01010-7")).to eq(7)
    end
  end
end
