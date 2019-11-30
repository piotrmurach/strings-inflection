# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#singular?" do
  {
    "doors" => false,
    "door" => true,
    "indices" => false,
    "index" => true
  }.each do |word, expected|
    it "checks if '#{word.inspect}' is a singular noun" do
      expect(Strings::Inflect.singular?(word)).to eq(expected)
    end
  end

  {
    "try" => false,
    "tries" => true,
    "go" => false,
    "goes" => true
  }.each do |word, expected|
    it "checks if '#{word.inspect}' is a singular verb" do
      expect(Strings::Inflect.singular?(word, term: :verb)).to eq(expected)
    end
  end

  it "fails when inflecting unknown term" do
    expect {
      Strings::Inflect.singular?("word", term: :unknown)
    }.to raise_error("Unknown option 'unknown' as a term")
  end
end
