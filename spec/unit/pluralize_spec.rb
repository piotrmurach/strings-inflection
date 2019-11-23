# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#pluralize" do
  inflections_example("nouns") do |singular, plural|
    it "pluralizes #{singular} -> #{plural}" do
      expect(Strings::Inflect.pluralize(singular)).to eq(plural)
    end
  end

  inflections_example("nounlist") do |singular, plural|
    it "pluralizes #{singular} -> #{plural}" do
      expect(Strings::Inflect.pluralize(singular)).to eq(plural)
    end
  end
end
