# frozen_string_literal: true

RSpec.describe Strings::Inflection, "#pluralize" do
  inflections_example("nouns") do |singular, plural|
    it "pluralizes #{singular} -> #{plural}" do
      expect(Strings::Inflection.pluralize(singular)).to eq(plural)
    end
  end

  it "pluralizes nounlist" do
    inflections_example("nounlist") do |singular, plural|
      expect(Strings::Inflection.pluralize(singular)).to eq(plural)
    end
  end

  inflections_example("verbs") do |singular, plural|
    it "pluralizes #{singular} -> #{plural}" do
      expect(Strings::Inflection.pluralize(singular, term: :verb)).to eq(plural)
    end
  end

  it "pluralizes verblist" do
    inflections_example("verblist") do |singular, plural|
      expect(Strings::Inflection.pluralize(singular, term: :verb)).to eq(plural)
    end
  end
end
