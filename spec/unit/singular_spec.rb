# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#singular?" do
  {
    "doors" => false,
    "door" => true,
    "indices" => false,
    "index" => true
  }.each do |word, expected|
    it "checks if a word is singular" do
      expect(Strings::Inflect.singular?(word)).to eq(expected)
    end
  end
end
