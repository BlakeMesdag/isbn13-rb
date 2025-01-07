# frozen_string_literal: true

RSpec.describe Isbn13 do
  it "has a version number" do
    expect(Isbn13::VERSION).not_to be nil
  end

  context "#checksum works for integer inputs" do
    it "works for integers without a checksum" do
      expect(Isbn13.checksum(978014300723)).to eq(4)
    end

    it "works for integers with an existing checksum" do
      expect(Isbn13.checksum(9780143007234)).to eq(4)
    end
  end

  context "#checksum works for string inputs" do
    it "works for strings without a checksum" do
      expect(Isbn13.checksum("978014300723")).to eq(4)
    end

    it "works for strings with a checksum" do
      expect(Isbn13.checksum("9780143007234")).to eq(4)
    end

    it "works for strings with dashes" do
      expect(Isbn13.checksum("978-0-143-00723")).to eq(4)
    end

    it "works for strings with dashes with a checksum" do
      expect(Isbn13.checksum("978-0-143-00723-4")).to eq(4)
    end
  end
end
