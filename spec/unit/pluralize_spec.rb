# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#pluralize" do
  inflections_example("inflections") do |singular, plural|
    it "pluralizes #{singular} -> #{plural}" do
      expect(Strings::Inflect.pluralize(singular)).to eq(plural)
    end
  end
end
