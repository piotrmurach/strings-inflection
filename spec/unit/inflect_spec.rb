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

  it "inflects singular verb" do
    expect(Strings::Inflect.inflect("tries", 2, term: :verb)).to eq("try")
  end

  it "inflects plural verb" do
    expect(Strings::Inflect.inflect("try", 1, term: :verb)).to eq("tries")
  end
end
