# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#singularize" do
  inflections_example("nouns") do |singular, plural|
    it "singularizes #{plural} -> #{singular}" do
      expect(Strings::Inflect.singularize(plural)).to eq(singular)
    end
  end
end
