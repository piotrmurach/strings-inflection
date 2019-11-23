# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#plural?" do
  {
    "doors" => true,
    "door" => false,
    "indices" => true,
    "index" => false
  }.each do |word, expected|
    it "checks if #{word.inspect} is plural" do
      expect(Strings::Inflect.plural?(word)).to eq(expected)
    end
  end
end
