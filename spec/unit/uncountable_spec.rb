# frozen_string_literal: true

RSpec.describe Strings::Inflection, "#uncountable?" do
  it "checks if noun is uncountable" do
    expect(Strings::Inflection.uncountable?("sheep")).to eq(true)
  end

  it "checks if noun is uncountable" do
    expect(Strings::Inflection.uncountable?("Sheep")).to eq(true)
  end

  it "checks if noun is countable" do
    expect(Strings::Inflection.uncountable?("error")).to eq(false)
  end
end
