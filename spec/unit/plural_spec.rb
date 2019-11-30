# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#plural?" do
  {
    "doors" => true,
    "door" => false,
    "indices" => true,
    "index" => false
  }.each do |word, expected|
    it "checks if '#{word.inspect}' is a plural noun" do
      expect(Strings::Inflect.plural?(word)).to eq(expected)
    end
  end

  {
    "try" => true,
    "tries" => false,
    "go" => true,
    "goes" => false
  }.each do |word, expected|
    it "checks if '#{word.inspect}' is a plural verb" do
      expect(Strings::Inflect.plural?(word, term: :verb)).to eq(expected)
    end
  end

  it "fails when inflecting unknown term" do
    expect {
      Strings::Inflect.plural?("word", term: :unknown)
    }.to raise_error("Unknown option 'unknown' as a term")
  end
end
