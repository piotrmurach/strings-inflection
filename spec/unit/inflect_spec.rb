# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#inflect" do
  it "inflects plural word to singular" do
    expect(Strings::Inflect.inflect("doors", 1)).to eq("door")
  end

  it "leaves plural uninflected" do
    expect(Strings::Inflect.inflect("doors", 2)).to eq("doors")
  end

  it "inflects singular word to plural" do
    expect(Strings::Inflect.inflect("door", 2)).to eq("doors")
  end

  it "leaves singular word uninflected" do
    expect(Strings::Inflect.inflect("door", 1)).to eq("door")
  end
end
