# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#uncountable?" do
  it "checks if noun is uncountable" do
    expect(Strings::Inflect.uncountable?("sheep")).to eq(true)
  end

  it "checks if noun is uncountable" do
    expect(Strings::Inflect.uncountable?("Sheep")).to eq(true)
  end

  it "checks if noun is countable" do
    expect(Strings::Inflect.uncountable?("error")).to eq(false)
  end
end
